$(document).delegate('.add-list', 'click', (evt) ->
  date = new Date()
  $('#list-table').append(template.replaceAll(':id', Number(date)))
  $('#list-' + Number(date)).fadeIn()
)

$(document).delegate('.remove-list', 'click', (evt) ->
  $(this).parent().parent().parent().fadeOut((evt) ->
    $(this).remove()
  )
)
$(document).delegate('.change-file-list', 'click', (evt) ->
  $(this).next().trigger('click')
)

$(document).delegate('.file-input-list', 'change', (evt) ->
  if (this.files and this.files[0])
    input = this
    reader = new FileReader()
    reader.onload = (e) ->
      filename = input.value.split(/(\\|\/)/g).pop()
      img = $(input).prev().prev()
      $(img).attr('src', e.target.result)
      $(img).attr('alt', filename)
    reader.readAsDataURL(input.files[0])
)


template = "
<tr id='list-:id' style='display: none;'>
  <td style='width: 83px;'>
    <div class='form-group' style='text-align: center;padding-right:50px'>
      <img src='/assets/default.png' width='140' height='100'>
      <a href='javascript:void(0)' class='change-file-list btn btn-mini'>Choose File</a>
      <input class='hidden file-input-list' id='finding_documents_attributes_:id_attachment' name='finding[documents_attributes][:id][attachment]' type='file'>
        
    </div>
  </td>
  <td style='vertical-align: middle;' >
    <div class='form-group'>
      <a href='javascript:void(0)' class='remove-list'>Remove</a>
    </div>
  </td>
 </tr>"
  
String.prototype.replaceAll = (search, replace) ->
  if(!replace)
      return this
  return this.replace(new RegExp(search, 'g'), replace)
  