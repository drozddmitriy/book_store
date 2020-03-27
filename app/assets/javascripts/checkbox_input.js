function checkForm(form) {
  if (form.check.checked) form.commit.disabled = 0
  else form.commit.disabled = 1
}
