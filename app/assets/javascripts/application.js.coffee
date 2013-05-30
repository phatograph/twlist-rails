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

    .on 'click', 'a#listsOwnerships', (e) ->
      e.preventDefault()

      el = $(@)
      ul = el.parents('ul')
      el.text('loading ..')

      $.get @href, (data, error) ->
        el.parent().remove()

        lists = ("<li><a href='#{d.url}'>#{d.name}</a></li>" for d in data.lists)
        if data.next_cursor
          lists.push "<li><a id='listsOwnerships' href='#{data.next_cursor}'>more</a></li>"
        ul.append(lists.join(''))

    .on 'click', 'a#listsMembers', (e) ->
      e.preventDefault()

      el = $(@)
      ul = el.parents('ol')
      el.text('loading ..')

      $.get @href, (data, error) ->
        el.parent().remove()

        lists = ("<li>#{d.name}</li>" for d in data.members)
        if data.next_cursor
          lists.push "<li><a id='listsMembers' href='#{data.next_cursor}'>more</a></li>"
        ul.append(lists.join(''))

  # $('a#usersFollowings').trigger('click')
  $('a#listsOwnerships').trigger('click')
  $('a#listsMembers').trigger('click')
