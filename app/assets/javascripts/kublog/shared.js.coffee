# Global helpers should be used in comments as well
window.setErrors = (model, errors) ->
  for attribute, error of errors
    $label = $("label[for=#{model}_#{attribute}]")
    $field = $("##{model}_#{attribute}")
    unless $label.size() is 0
      $label.addClass('error')
      $(errorTemplate(error[0])).insertAfter($label)
    else
      $field.addClass('error')
      $(errorTemplate(error[0])).insertAfter($field)
    
window.resetErrors = ->
  $('.error').removeClass('error')
  $('small.error_description').remove()
    
window.errorTemplate = (error) -> "<small class='error_description'>#{error}</small>"

if $("meta[content='kublog_path']").length > 0
  window.kublogPath = $("meta[content='kublog_path']").attr("name")
else
  window.kublogPath = "/blog"