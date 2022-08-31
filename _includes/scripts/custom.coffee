# In .previous remove double bottom border if last row is .future
if $("table.previous tr:last-of-type.future").length
  $("table.previous tr:nth-last-child(2) td").css('border-bottom', 0)