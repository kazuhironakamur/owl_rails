# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/
$(document).on 'turbolinks:load', ->

  # queryStringをhashtable化してくれるmethod。
  # バグがあったらごめんね…。by 中村
  getQueryString = ->
    vars = []

    qsi = window.location.href.indexOf("?")
    return vars if qsi is -1

    qs = window.location.href.slice(qsi + 1)

    sri = qs.indexOf("#")
    qs = qs.slice(0, sri) if sri >= 0

    hashes = qs.split("&")
    for hash in hashes
      words = hash.split(",")
      for word in words
        sep = hash.indexOf("=")
        continue if sep <= 0
        key = decodeURIComponent(hash.slice(0, sep))
        val = decodeURIComponent(hash.slice(sep + 1))

        if key of vars == true
          if typeof vars[key] == 'string'
            tmp = []
            tmp.push vars[key]
            tmp.push val
            vars[key] = tmp
          else
            vars[key].push val
        else
          vars[key] = val
    vars

  # ブランドの<select>の中身を生成する
  # 優先的に処理するために、janなどのloadより上に書いてね
  $.get 'http://rrrapi.dad-way.local/brandmta', (brands) ->
    for b in brands
      $('select#brand_code').append '<option value="' + b['clsid'] + '">' + b['clsnm'] + '</option>'
    
    selected_brand = getQueryString()['brand_code[]']
    for b in selected_brand
      $('select#brand_code').val selected_brand
  
  $('.ajax-autocomplete').each ->
    $(@).attr 'list', $(@).attr('id') + '_list'
    $(@).attr 'autocomplete', 'off'
  
  $('.ajax-autocomplete').on 'input', ->
    callback = (tbox) ->
      console.time('timer')

      if $(tbox).val().length == 0
        return
      
      if $(tbox).val().match '^[a-zA-Z0-9]{1}$'
        return
      
      table = $(tbox).attr('table')
      column = $(tbox).attr('column')
      
      $.ajax 'http://rrrapi.dad-way.local/' + table + '/filter?' + column + '=' + $(tbox).val() + '&row_limit=5',
        cache: false
        timeout: 1000,
        success: (res, status, xhr) ->
          datalist = ''
          $('datalist#name_list > option').remove()
          for r in res
            datalist += '<option value="' + r.hinnma.trim() + '">' + r.hincd.trim()+ '</option>'
          $('datalist#name_list').html datalist
          console.log status + ', success'
          return
        error: (xhr, status, err) ->
          $('datalist#name_list > option').remove()
          console.log status + ', error'
        complete: (xhr, status) ->
          console.log status + ', complete'
      console.timeEnd('timer')
      
      return

    t = $(this)
    setTimeout ( -> callback(t)), 300
      
  # JANを取得し、セットする
  set_jan = (code) ->
    (jan) ->
      $('#' + code + '.jsjancd').html jan[0]['jsjancd']
      $('#' + code + '.mkjancd').html jan[0]['mkjancd']
      return

  # ブランドを取得し、セットする
  set_brand = (code) ->
    (brand) ->
      $('#' + code + '.clsnm').html brand[0]['clsnm']
      return

  # JANとブランドを取得する
  $('#tbl .code').each ->
    code = $(this).html()
    $.get 'http://rrrapi.dad-way.local/hinjancd/' + code, set_jan(code)
    $.get 'http://rrrapi.dad-way.local/hinmta/' + code, set_brand(code)
    return

  return