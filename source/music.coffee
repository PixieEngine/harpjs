###*
The Music object provides an easy API to play
songs from your sounds project directory. By
default, the track is looped.

<code><pre>
  Music.play('intro_theme')
</pre></code>

@name Music
@namespace
###

Music = (->
  # TODO: Load this from local storage of user preferences
  globalMusicVolume = 1
  trackVolume = 1

  # TODO: Add format fallbacks
  track = $ "<audio />",
    loop: "loop"
  .appendTo('body').get(0)

  appendSources = (audio, name) ->
    [
      ["ogg", "audio/ogg"]
      ["mp3", "audio/mpeg"]
    ].forEach ([extension, mimeType]) ->
      source = document.createElement('source')
      source.type = mimeType
      source.src = "#{name}.#{extension}"
      audio.appendChild(source)

  updateTrackVolume = ->
    track.volume = globalMusicVolume * trackVolume

  ###*
  Set the global volume modifier for all music.

  Any value set is clamped between 0 and 1. This is multiplied
  into each individual track that plays.

  If no argument is given return the current global music volume.

  @name globalVolume
  @methodOf Music
  @param {Number} [newVolume] The volume to set
  ###
  globalVolume: (newVolume) ->
    if newVolume?
      globalMusicVolume = newVolume.clamp(0, 1)

      updateTrackVolume()

    return globalMusicVolume

  ###*
  Plays a music track.

  @name play
  @methodOf Music
  @param {String} name The name of the track to play.
  ###
  play: (name) ->
    updateTrackVolume()

    appendSources(track, "#{BASE_URL}/music/#{name}")

    track.play()

  ###*
  Get or set the current music volume. Any value passed is
  clamped between 0 and 1. Use this to adjust the volume of
  individual tracks or to increase or decrease volume during
  gameplay.

  @name volume
  @methodOf Music
  @param {Number} [newVolume] The volume to set to.
  ###
  volume: (newVolume) ->
    if newVolume?
      trackVolume = newVolume.clamp(0, 1)
      updateTrackVolume()

      return this
    else
      return trackVolume
)()
