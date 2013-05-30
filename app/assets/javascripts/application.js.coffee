#= require jquery
#= require jquery_ujs
#= require_tree .

$ ->
  $(document)
    .on 'click', 'a#usersFollowings', (e) ->
      e.preventDefault()

      el = $(@)
      ul = el.parents('ul')
      el.text('loading ..')

      $.get @href, (data, error) ->
        el.parent().remove()

        followings = ("<li>#{d}</li>" for d in data.followings)
        if data.next_cursor
          followings.push "<li><a id='usersFollowings' href='#{data.next_cursor}'>more</a></li>"
        ul.append(followings.join(''))

  $('a#usersFollowings').trigger('click')
