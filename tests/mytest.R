app <- ShinyDriver$new("../")
app$snapshotInit("mytest")

app$setInputs(name = "Hadley")
app$setInputs(go = "click")
app$snapshot()
app$setInputs(name = "")
app$setInputs(go = "click")
app$snapshot()
