### @ngInject ###
processStatesProvider = () ->

  serviceProvider = ->

    isClean = =>
      return @state == 'clean'

    isPending = =>
      return @state == 'pending'

    isSucceeded = =>
      return @state == 'succeeded'

    isFailed = =>
      return @state == 'failed'

    setPending = =>
      @state = 'pending'

    setSucceeded = =>
      @state = 'succeeded'

    setFailed = =>
      @state = 'failed'

    # # # # # # # # # # # # # # # # # # #

    @state = 'clean'
    @isClean = isClean
    @isPending = isPending
    @isSucceeded = isSucceeded
    @isFailed = isFailed
    @setPending = setPending
    @setSucceeded = setSucceeded
    @setFailed = setFailed
    return

  getInstance = =>
    return new serviceProvider()

  # # # # # # # # # # # # # # # # # # #

  return {
    getInstance: getInstance
  }

angular
  .module('ngStates')
  .factory('processStatesProvider', processStatesProvider)
