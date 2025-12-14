# ROC CURVE ANALYSIS ----

# Install and load necessary packages
install.packages(c("pROC", "mlbench"))
library(pROC)
library(mlbench)

# Load built-in dataset
data(PimaIndiansDiabetes)

df <- PimaIndiansDiabetes
names(df); dim(df)
head(df)
hist(df$glucose)  # Visualize distribution of glucose

## 1. Basic ROC curves ----

# Evaluate diagnostic ability of a single variable (glucose) to detect diabetes (yes/no)
roc_obj <- roc(df$diabetes, df$glucose)
roc_smooth <- roc(df$diabetes, df$glucose, smooth = TRUE)

plot(roc_obj)
plot(roc_smooth)

# Area Under the Curve (AUC)
auc(roc_obj)

# Coordinates (sensitivity, specificity, etc.)
coords(roc_obj, transpose = FALSE)

## 2. ROC curve with AUC and confidence intervals (CI) ----

rocobj <- plot.roc(
  df$diabetes,
  df$glucose,
  main = "ROC Curve with CI (Diabetes)",
  percent = TRUE,
  ci = TRUE,
  print.auc = TRUE
)

## 3. Confidence intervals for sensitivity ----

ciobj <- ci.se(rocobj, specificities = seq(0, 100, 5))
plot(ciobj, type = "shape", col = "#1c61b6AA")  # Plot CI as a semi-transparent blue shape

## 4. Optimal cutoff point (threshold = best) ----

plot(ci(rocobj, of = "thresholds", thresholds = "best"))

umbral <- plot.roc(
  df$diabetes,
  df$glucose,
  main = "Optimal Threshold",
  percent = TRUE,
  ci = TRUE,
  print.auc = TRUE,
  of = "thresholds",
  thresholds = "best",
  print.thres = "best"
)

plot(ciobj, type = "shape", col = "#1c61b6AA")

## 5. Comparison of two ROC curves ----

Predictor1 <- plot.roc(
  df$diabetes,
  df$glucose,
  main = "ROC Curve Comparison",
  col = "#1c61b6"
)

Predictor2 <- lines.roc(
  df$diabetes,
  df$mass,
  col = "#008600"
)

testobj <- roc.test(Predictor1, Predictor2)

text(
  .5, .5,
  labels = paste("p-value =", format.pval(testobj$p.value)),
  adj = c(0, .5)
)

legend(
  "bottomright",
  legend = c("Glucose", "BMI"),
  col = c("#1c61b6", "#008600"),
  lwd = 2
)

# NEW CASE ----

# Prepare new dataset
data(BreastCancer)

# Remove missing values
df <- na.omit(BreastCancer)
head(df)
dim(df)

# Response variable
df$Class <- factor(df$Class, levels = c("benign", "malignant"))

# Convert predictors to numeric
df[, 2:10] <- lapply(df[, 2:10], function(x) as.numeric(as.character(x)))

## 1. ROC using a SINGLE variable ----
roc_bc <- roc(df$Class, df$Cell.size)

plot(roc_bc, print.auc = TRUE, col = "darkred")
auc(roc_bc)

umbral <- plot.roc(
  df$Class,
  df$Cell.size,
  main = "Optimal Threshold",
  percent = TRUE,
  ci = TRUE,
  print.auc = TRUE,
  of = "thresholds",
  thresholds = "best",
  print.thres = "best"
)

coords(roc_bc, transpose = FALSE)

## 2. ROC using MULTIPLE variables ----

# No single variable is sufficient; the marker is the estimated probability from a glm()
# Does combining several variables discriminate better than a single one?

modelo <- glm(
  Class ~ Cell.size + Cell.shape + Bare.nuclei,
  data = df,
  family = binomial
)

prob <- predict(modelo, type = "response")

roc_mod <- roc(df$Class, prob)

plot(roc_mod, print.auc = TRUE, col = "blue")

# Compare with previous single-variable ROC
plot(roc_mod,
     print.auc = TRUE,
     col = "blue",
     main = "ROC Curve Comparison")

lines(roc_bc,
      col = "darkred",
      print.auc = TRUE,
      print.auc.y = 40)

legend("bottomright",
       legend = c("Multivariable Model", "Cell.size"),
       col = c("blue", "darkred"),
       lwd = 2)
