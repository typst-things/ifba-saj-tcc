// charts.typ — Gráficos de datos generados programáticamente (cetz-plot).

#import "@preview/cetz:0.4.2": canvas
#import "@preview/cetz-plot:0.1.3": chart

// 📈 Gráfico de pizza.
#let pie-chart(
  data,
  value-key: "value",
  label-key: "label",
) = canvas({
  chart.piechart(
    data,
    value-key: value-key,
    label-key: label-key,
  )
})

// 📈 Gráfico de columnas/barras.
#let bar-chart(
  data,
  label-key: 0,
  value-key: 1,
) = canvas({
  chart.columnchart(
    data,
    label-key: label-key,
    value-key: value-key,
  )
})