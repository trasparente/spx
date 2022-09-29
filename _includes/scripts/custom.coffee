# In .previous remove double bottom border if last row is .future
if $("table tr.previous:last-of-type.future").length
  $("table tr.previous:nth-last-child(2) td").css('border-bottom', 0)