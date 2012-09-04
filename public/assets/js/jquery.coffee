#! jQuery v@1.8.0 jquery.com | jquery.org/license 
((a, b) ->
  G = (a) ->
    b = F[a] = {}
    p.each(a.split(s), (a, c) ->
      b[c] = not 0
    )
    b
  J = (a, c, d) ->
    if d is b and a.nodeType is 1
      e = "data-" + c.replace(I, "-$1").toLowerCase()
      d = a.getAttribute(e)
      if typeof d is "string"
        try
          d = (if d is "true" then not 0 else (if d is "false" then not 1 else (if d is "null" then null else (if +d + "" is d then +d else (if H.test(d) then p.parseJSON(d) else d)))))
        p.data a, c, d
      else
        d = b
    d
  K = (a) ->
    b = undefined
    for b of a
      continue  if b is "data" and p.isEmptyObject(a[b])
      return not 1  if b isnt "toJSON"
    not 0
  ba = ->
    not 1
  bb = ->
    not 0
  bh = (a) ->
    not a or not a.parentNode or a.parentNode.nodeType is 11
  bi = (a, b) ->
    loop
      a = a[b]
      break unless a and a.nodeType isnt 1
    a
  bj = (a, b, c) ->
    b = b or 0
    if p.isFunction(b)
      return p.grep(a, (a, d) ->
        e = !!b.call(a, d, a)
        e is c
      )
    if b.nodeType
      return p.grep(a, (a, d) ->
        a is b is c
      )
    if typeof b is "string"
      d = p.grep(a, (a) ->
        a.nodeType is 1
      )
      return p.filter(b, d, not c)  if be.test(b)
      b = p.filter(b, d)
    p.grep a, (a, d) ->
      p.inArray(a, b) >= 0 is c

  bk = (a) ->
    b = bl.split("|")
    c = a.createDocumentFragment()
    c.createElement b.pop()  while b.length  if c.createElement
    c
  bC = (a, b) ->
    a.getElementsByTagName(b)[0] or a.appendChild(a.ownerDocument.createElement(b))
  bD = (a, b) ->
    return  if b.nodeType isnt 1 or not p.hasData(a)
    c = undefined
    d = undefined
    e = undefined
    f = p._data(a)
    g = p._data(b, f)
    h = f.events
    if h
      delete g.handle

      g.events = {}

      for c of h
        d = 0
        e = h[c].length

        while d < e
          p.event.add b, c, h[c][d]
          d++
    g.data and (g.data = p.extend({}, g.data))
  bE = (a, b) ->
    c = undefined
    return  if b.nodeType isnt 1
    b.clearAttributes and b.clearAttributes()
    b.mergeAttributes and b.mergeAttributes(a)
    c = b.nodeName.toLowerCase()
    (if c is "object" then (b.parentNode and (b.outerHTML = a.outerHTML)
    p.support.html5Clone and a.innerHTML and not p.trim(b.innerHTML) and (b.innerHTML = a.innerHTML)
    ) else (if c is "input" and bv.test(a.type) then (b.defaultChecked = b.checked = a.checked
    b.value isnt a.value and (b.value = a.value)
    ) else (if c is "option" then b.selected = a.defaultSelected else (if c is "input" or c is "textarea" then b.defaultValue = a.defaultValue else c is "script" and b.text isnt a.text and (b.text = a.text)))))
    b.removeAttribute(p.expando)
  bF = (a) ->
    (if typeof a.getElementsByTagName isnt "undefined" then a.getElementsByTagName("*") else (if typeof a.querySelectorAll isnt "undefined" then a.querySelectorAll("*") else []))
  bG = (a) ->
    bv.test(a.type) and (a.defaultChecked = a.checked)
  bX = (a, b) ->
    return b  if b of a
    c = b.charAt(0).toUpperCase() + b.slice(1)
    d = b
    e = bV.length
    while e--
      b = bV[e] + c
      return b  if b of a
    d
  bY = (a, b) ->
    a = b or a
    p.css(a, "display") is "none" or not p.contains(a.ownerDocument, a)
  bZ = (a, b) ->
    c = undefined
    d = undefined
    e = []
    f = 0
    g = a.length
    while f < g
      c = a[f]
      continue  unless c.style
      e[f] = p._data(c, "olddisplay")
      (if b then (not e[f] and c.style.display is "none" and (c.style.display = "")
      c.style.display is "" and bY(c) and (e[f] = p._data(c, "olddisplay", cb(c.nodeName)))
      ) else (d = bH(c, "display")
      not e[f] and d isnt "none" and p._data(c, "olddisplay", d)
      ))
      f++
    f = 0
    while f < g
      c = a[f]
      continue  unless c.style
      c.style.display = (if b then e[f] or "" else "none")  if not b or c.style.display is "none" or c.style.display is ""
      f++
    a
  b$ = (a, b, c) ->
    d = bO.exec(b)
    (if d then Math.max(0, d[1] - (c or 0)) + (d[2] or "px") else b)
  b_ = (a, b, c, d) ->
    e = (if c is ((if d then "border" else "content")) then 4 else (if b is "width" then 1 else 0))
    f = 0
    while e < 4
      c is "margin" and (f += p.css(a, c + bU[e], not 0))
      (if d then (c is "content" and (f -= parseFloat(bH(a, "padding" + bU[e])) or 0)
      c isnt "margin" and (f -= parseFloat(bH(a, "border" + bU[e] + "Width")) or 0)
      ) else (f += parseFloat(bH(a, "padding" + bU[e])) or 0
      c isnt "padding" and (f += parseFloat(bH(a, "border" + bU[e] + "Width")) or 0)
      ))
      e += 2
    f
  ca = (a, b, c) ->
    d = (if b is "width" then a.offsetWidth else a.offsetHeight)
    e = not 0
    f = p.support.boxSizing and p.css(a, "boxSizing") is "border-box"
    if d <= 0
      d = bH(a, b)
      d = a.style[b]  if d < 0 or not d?
      return d  if bP.test(d)
      e = f and (p.support.boxSizingReliable or d is a.style[b])
      d = parseFloat(d) or 0
    d + b_(a, b, c or ((if f then "border" else "content")), e) + "px"
  cb = (a) ->
    return bR[a]  if bR[a]
    b = p("<" + a + ">").appendTo(e.body)
    c = b.css("display")
    b.remove()
    if c is "none" or c is ""
      bI = e.body.appendChild(bI or p.extend(e.createElement("iframe"),
        frameBorder: 0
        width: 0
        height: 0
      ))
      if not bJ or not bI.createElement
        bJ = (bI.contentWindow or bI.contentDocument).document
        bJ.write("<!doctype html><html><body>")
        bJ.close()
      b = bJ.body.appendChild(bJ.createElement(a))
      c = bH(b, "display")
      e.body.removeChild(bI)
    bR[a] = c
    c
  ch = (a, b, c, d) ->
    e = undefined
    if p.isArray(b)
      p.each b, (b, e) ->
        (if c or cd.test(a) then d(a, e) else ch(a + "[" + ((if typeof e is "object" then b else "")) + "]", e, c, d))

    else if not c and p.type(b) is "object"
      for e of b
        ch a + "[" + e + "]", b[e], c, d
    else
      d a, b
  cy = (a) ->
    (b, c) ->
      typeof b isnt "string" and (c = b
      b = "*"
      )
      d = undefined
      e = undefined
      f = undefined
      g = b.toLowerCase().split(s)
      h = 0
      i = g.length
      if p.isFunction(c)
        while h < i
          d = g[h]
          f = /^\+/.test(d)
          f and (d = d.substr(1) or "*")
          e = a[d] = a[d] or []
          e[(if f then "unshift" else "push")](c)
          h++
  cz = (a, c, d, e, f, g) ->
    f = f or c.dataTypes[0]
    g = g or {}
    g[f] = not 0

    h = undefined
    i = a[f]
    j = 0
    k = (if i then i.length else 0)
    l = a is cu
    while j < k and (l or not h)
      h = i[j](c, d, e)
      typeof h is "string" and ((if not l or g[h] then h = b else (c.dataTypes.unshift(h)
      h = cz(a, c, d, e, h, g)
      )))
      j++
    (l or not h) and not g["*"] and (h = cz(a, c, d, e, "*", g))
    h
  cA = (a, c) ->
    d = undefined
    e = undefined
    f = p.ajaxSettings.flatOptions or {}
    for d of c
      c[d] isnt b and (((if f[d] then a else e or (e = {})))[d] = c[d])
    e and p.extend(not 0, a, e)
  cB = (a, c, d) ->
    e = undefined
    f = undefined
    g = undefined
    h = undefined
    i = a.contents
    j = a.dataTypes
    k = a.responseFields
    for f of k
      f of d and (c[k[f]] = d[f])
    while j[0] is "*"
      j.shift()
      e is b and (e = a.mimeType or c.getResponseHeader("content-type"))
    if e
      for f of i
        if i[f] and i[f].test(e)
          j.unshift f
          break
    unless j[0] of d
      for f of d
        if not j[0] or a.converters[f + " " + j[0]]
          g = f
          break
        h or (h = f)
      g = g or h
    if g
      g isnt j[0] and j.unshift(g)
      d[g]
  cC = (a, b) ->
    c = undefined
    d = undefined
    e = undefined
    f = undefined
    g = a.dataTypes.slice()
    h = g[0]
    i = {}
    j = 0
    a.dataFilter and (b = a.dataFilter(b, a.dataType))
    if g[1]
      for c of a.converters
        i[c.toLowerCase()] = a.converters[c]
    while e = g[++j]
      if e isnt "*"
        if h isnt "*" and h isnt e
          c = i[h + " " + e] or i["* " + e]
          unless c
            for d of i
              f = d.split(" ")
              if f[1] is e
                c = i[h + " " + f[0]] or i["* " + f[0]]
                if c
                  (if c is not 0 then c = i[d] else i[d] isnt not 0 and (e = f[0]
                  g.splice(j--, 0, e)
                  ))
                  break
          if c isnt not 0
            if c and a["throws"]
              b = c(b)
            else
              try
                b = c(b)
              catch k
                return (
                  state: "parsererror"
                  error: (if c then k else "No conversion from " + h + " to " + e)
                )
        h = e
    state: "success"
    data: b
  cK = ->
    try
      return new a.XMLHttpRequest
  cL = ->
    try
      return new a.ActiveXObject("Microsoft.XMLHTTP")
  cT = ->
    setTimeout(->
      cM = b
    , 0)
    cM = p.now()
  cU = (a, b) ->
    p.each b, (b, c) ->
      d = (cS[b] or []).concat(cS["*"])
      e = 0
      f = d.length
      while e < f
        return  if d[e].call(a, b, c)
        e++

  cV = (a, b, c) ->
    d = undefined
    e = 0
    f = 0
    g = cR.length
    h = p.Deferred().always(->
      delete i.elem
    )
    i = ->
      b = cM or cT()
      c = Math.max(0, j.startTime + j.duration - b)
      d = 1 - (c / j.duration or 0)
      e = 0
      f = j.tweens.length
      while e < f
        j.tweens[e].run d
        e++
      h.notifyWith(a, [j, d, c])
      (if d < 1 and f then c else (h.resolveWith(a, [j])
      not 1
      ))

    j = h.promise(
      elem: a
      props: p.extend({}, b)
      opts: p.extend(not 0,
        specialEasing: {}
      , c)
      originalProperties: b
      originalOptions: c
      startTime: cM or cT()
      duration: c.duration
      tweens: []
      createTween: (b, c, d) ->
        e = p.Tween(a, j.opts, b, c, j.opts.specialEasing[b] or j.opts.easing)
        j.tweens.push(e)
        e

      stop: (b) ->
        c = 0
        d = (if b then j.tweens.length else 0)
        while c < d
          j.tweens[c].run 1
          c++
        (if b then h.resolveWith(a, [j, b]) else h.rejectWith(a, [j, b]))
        this
    )
    k = j.props
    cW k, j.opts.specialEasing
    while e < g
      d = cR[e].call(j, a, k, j.opts)
      return d  if d
      e++
    cU(j, k)
    p.isFunction(j.opts.start) and j.opts.start.call(a, j)
    p.fx.timer(p.extend(i,
      anim: j
      queue: j.opts.queue
      elem: a
    ))
    j.progress(j.opts.progress).done(j.opts.done, j.opts.complete).fail(j.opts.fail).always(j.opts.always)
  cW = (a, b) ->
    c = undefined
    d = undefined
    e = undefined
    f = undefined
    g = undefined
    for c of a
      d = p.camelCase(c)
      e = b[d]
      f = a[c]
      p.isArray(f) and (e = f[1]
      f = a[c] = f[0]
      )
      c isnt d and (a[d] = f
      delete a[c]

      )
      g = p.cssHooks[d]

      if g and "expand" of g
        f = g.expand(f)
        delete a[d]


        for c of f
          c of a or (a[c] = f[c]
          b[c] = e
          )
      else
        b[d] = e
  cX = (a, b, c) ->
    d = undefined
    e = undefined
    f = undefined
    g = undefined
    h = undefined
    i = undefined
    j = undefined
    k = undefined
    l = this
    m = a.style
    n = {}
    o = []
    q = a.nodeType and bY(a)
    c.queue or (j = p._queueHooks(a, "fx")
    not j.unqueued? and (j.unqueued = 0
    k = j.empty.fire
    j.empty.fire = ->
      j.unqueued or k()

    )
    j.unqueued++
    l.always(->
      l.always ->
        j.unqueued--
        p.queue(a, "fx").length or j.empty.fire()

    )
    )
    a.nodeType is 1 and ("height" of b or "width" of b) and (c.overflow = [m.overflow, m.overflowX, m.overflowY]
    p.css(a, "display") is "inline" and p.css(a, "float") is "none" and ((if not p.support.inlineBlockNeedsLayout or cb(a.nodeName) is "inline" then m.display = "inline-block" else m.zoom = 1))
    )
    c.overflow and (m.overflow = "hidden"
    p.support.shrinkWrapBlocks or l.done(->
      m.overflow = c.overflow[0]
      m.overflowX = c.overflow[1]
      m.overflowY = c.overflow[2]
    )
    )

    for d of b
      f = b[d]
      if cO.exec(f)
        delete b[d]

        continue  if f is ((if q then "hide" else "show"))
        o.push d
    g = o.length
    if g
      h = p._data(a, "fxshow") or p._data(a, "fxshow", {})
      (if q then p(a).show() else l.done(->
        p(a).hide()
      ))
      l.done(->
        b = undefined
        p.removeData a, "fxshow", not 0
        for b of n
          p.style a, b, n[b]
      )

      d = 0
      while d < g
        e = o[d]
        i = l.createTween(e, (if q then h[e] else 0))
        n[e] = h[e] or p.style(a, e)
        e of h or (h[e] = i.start
        q and (i.end = i.start
        i.start = (if e is "width" or e is "height" then 1 else 0)
        )
        )
        d++
  cY = (a, b, c, d, e) ->
    new cY::init(a, b, c, d, e)
  cZ = (a, b) ->
    c = undefined
    d = height: a
    e = 0
    while e < 4
      c = bU[e]
      d["margin" + c] = d["padding" + c] = a
      e += 2 - b
    b and (d.opacity = d.width = a)
    d
  c_ = (a) ->
    (if p.isWindow(a) then a else (if a.nodeType is 9 then a.defaultView or a.parentWindow else not 1))
  c = undefined
  d = undefined
  e = a.document
  f = a.location
  g = a.navigator
  h = a.jQuery
  i = a.$
  j = Array::push
  k = Array::slice
  l = Array::indexOf
  m = Object::toString
  n = Object::hasOwnProperty
  o = String::trim
  p = (a, b) ->
    new p.fn.init(a, b, c)

  q = /[\-+]?(?:\d*\.|)\d+(?:[eE][\-+]?\d+|)/.source
  r = /\S/
  s = /\s+/
  t = (if r.test(" ") then /^[\s\xA0]+|[\s\xA0]+$/g else /^\s+|\s+$/g)
  u = /^(?:[^#<]*(<[\w\W]+>)[^>]*$|#([\w\-]*)$)/
  v = /^<(\w+)\s*\/?>(?:<\/\1>|)$/
  w = /^[\],:{}\s]*$/
  x = /(?:^|:|,)(?:\s*\[)+/g
  y = /\\(?:["\\\/bfnrt]|u[\da-fA-F]{4})/g
  z = /"[^"\\\r\n]*"|true|false|null|-?(?:\d\d*\.|)\d+(?:[eE][\-+]?\d+|)/g
  A = /^-ms-/
  B = /-([\da-z])/g
  C = (a, b) ->
    (b + "").toUpperCase()

  D = ->
    (if e.addEventListener then (e.removeEventListener("DOMContentLoaded", D, not 1)
    p.ready()
    ) else e.readyState is "complete" and (e.detachEvent("onreadystatechange", D)
    p.ready()
    ))

  E = {}
  p.fn = p:: =
    constructor: p
    init: (a, c, d) ->
      f = undefined
      g = undefined
      h = undefined
      i = undefined
      return this  unless a
      if a.nodeType
        return @context = this[0] = a
        @length = 1
        this
      if typeof a is "string"
        (if a.charAt(0) is "<" and a.charAt(a.length - 1) is ">" and a.length >= 3 then f = [null, a, null] else f = u.exec(a))
        if f and (f[1] or not c)
          if f[1]
            return c = (if c instanceof p then c[0] else c)
            i = (if c and c.nodeType then c.ownerDocument or c else e)
            a = p.parseHTML(f[1], i, not 0)
            v.test(f[1]) and p.isPlainObject(c) and @attr.call(a, c, not 0)
            p.merge(this, a)
          g = e.getElementById(f[2])
          if g and g.parentNode
            return d.find(a)  if g.id isnt f[2]
            @length = 1
            this[0] = g
          return @context = e
          @selector = a
          this
        return (if not c or c.jquery then (c or d).find(a) else @constructor(c).find(a))
      (if p.isFunction(a) then d.ready(a) else (a.selector isnt b and (@selector = a.selector
      @context = a.context
      )
      p.makeArray(a, this)
      ))

    selector: ""
    jquery: "1.8.0"
    length: 0
    size: ->
      @length

    toArray: ->
      k.call this

    get: (a) ->
      (if not a? then @toArray() else (if a < 0 then this[@length + a] else this[a]))

    pushStack: (a, b, c) ->
      d = p.merge(@constructor(), a)
      d.prevObject = this
      d.context = @context
      (if b is "find" then d.selector = @selector + ((if @selector then " " else "")) + c else b and (d.selector = @selector + "." + b + "(" + c + ")"))
      d

    each: (a, b) ->
      p.each this, a, b

    ready: (a) ->
      p.ready.promise().done(a)
      this

    eq: (a) ->
      a = +a
      (if a is -1 then @slice(a) else @slice(a, a + 1))

    first: ->
      @eq 0

    last: ->
      @eq -1

    slice: ->
      @pushStack k.apply(this, arguments_), "slice", k.call(arguments_).join(",")

    map: (a) ->
      @pushStack p.map(this, (b, c) ->
        a.call b, c, b
      )

    end: ->
      @prevObject or @constructor(null)

    push: j
    sort: [].sort
    splice: [].splice

  p.fn.init:: = p.fn
  p.extend = p.fn.extend = ->
    a = undefined
    c = undefined
    d = undefined
    e = undefined
    f = undefined
    g = undefined
    h = arguments_[0] or {}
    i = 1
    j = arguments_.length
    k = not 1
    typeof h is "boolean" and (k = h
    h = arguments_[1] or {}
    i = 2
    )
    typeof h isnt "object" and not p.isFunction(h) and (h = {})
    j is i and (h = this
    --i
    )

    while i < j
      if (a = arguments_[i])?
        for c of a
          d = h[c]
          e = a[c]

          continue  if h is e
          (if k and e and (p.isPlainObject(e) or (f = p.isArray(e))) then ((if f then (f = not 1
          g = (if d and p.isArray(d) then d else [])
          ) else g = (if d and p.isPlainObject(d) then d else {}))
          h[c] = p.extend(k, g, e)
          ) else e isnt b and (h[c] = e))
      i++
    h

  p.extend(
    noConflict: (b) ->
      a.$ is p and (a.$ = i)
      b and a.jQuery is p and (a.jQuery = h)
      p

    isReady: not 1
    readyWait: 1
    holdReady: (a) ->
      (if a then p.readyWait++ else p.ready(not 0))

    ready: (a) ->
      return  if (if a is not 0 then --p.readyWait else p.isReady)
      return setTimeout(p.ready, 1)  unless e.body
      p.isReady = not 0
      return  if a isnt not 0 and --p.readyWait > 0
      d.resolveWith(e, [p])
      p.fn.trigger and p(e).trigger("ready").off("ready")

    isFunction: (a) ->
      p.type(a) is "function"

    isArray: Array.isArray or (a) ->
      p.type(a) is "array"

    isWindow: (a) ->
      a? and a is a.window

    isNumeric: (a) ->
      not isNaN(parseFloat(a)) and isFinite(a)

    type: (a) ->
      (if not a? then String(a) else E[m.call(a)] or "object")

    isPlainObject: (a) ->
      return not 1  if not a or p.type(a) isnt "object" or a.nodeType or p.isWindow(a)
      try
        return not 1  if a.constructor and not n.call(a, "constructor") and not n.call(a.constructor::, "isPrototypeOf")
      catch c
        return not 1
      d = undefined
      for d of a

      d is b or n.call(a, d)

    isEmptyObject: (a) ->
      b = undefined
      for b of a
        return not 1
      not 0

    error: (a) ->
      throw new Error(a)

    parseHTML: (a, b, c) ->
      d = undefined
      (if not a or typeof a isnt "string" then null else (typeof b is "boolean" and (c = b
      b = 0
      )
      b = b or e
      (if (d = v.exec(a)) then [b.createElement(d[1])] else (d = p.buildFragment([a], b, (if c then null else []))
      p.merge([], ((if d.cacheable then p.clone(d.fragment) else d.fragment)).childNodes)
      ))
      ))

    parseJSON: (b) ->
      return null  if not b or typeof b isnt "string"
      b = p.trim(b)
      return a.JSON.parse(b)  if a.JSON and a.JSON.parse
      return (new Function("return " + b))()  if w.test(b.replace(y, "@").replace(z, "]").replace(x, ""))
      p.error "Invalid JSON: " + b

    parseXML: (c) ->
      d = undefined
      e = undefined
      return null  if not c or typeof c isnt "string"
      try
        (if a.DOMParser then (e = new DOMParser
        d = e.parseFromString(c, "text/xml")
        ) else (d = new ActiveXObject("Microsoft.XMLDOM")
        d.async = "false"
        d.loadXML(c)
        ))
      catch f
        d = b
      (not d or not d.documentElement or d.getElementsByTagName("parsererror").length) and p.error("Invalid XML: " + c)
      d

    noop: ->

    globalEval: (b) ->
      b and r.test(b) and (a.execScript or (b) ->
        a.eval.call a, b
      )(b)

    camelCase: (a) ->
      a.replace(A, "ms-").replace B, C

    nodeName: (a, b) ->
      a.nodeName and a.nodeName.toUpperCase() is b.toUpperCase()

    each: (a, c, d) ->
      e = undefined
      f = 0
      g = a.length
      h = g is b or p.isFunction(a)
      if d
        if h
          for e of a
            break  if c.apply(a[e], d) is not 1
        else
          while f < g
            break  if c.apply(a[f++], d) is not 1
      else if h
        for e of a
          break  if c.call(a[e], e, a[e]) is not 1
      else
        while f < g
          break  if c.call(a[f], f, a[f++]) is not 1
      a

    trim: (if o then (a) ->
      (if not a? then "" else o.call(a))
     else (a) ->
      (if not a? then "" else a.toString().replace(t, ""))
    )
    makeArray: (a, b) ->
      c = undefined
      d = b or []
      a? and (c = p.type(a)
      (if not a.length? or c is "string" or c is "function" or c is "regexp" or p.isWindow(a) then j.call(d, a) else p.merge(d, a))
      )
      d

    inArray: (a, b, c) ->
      d = undefined
      if b
        return l.call(b, a, c)  if l
        d = b.length
        c = (if c then (if c < 0 then Math.max(0, d + c) else c) else 0)

        while c < d
          return c  if c of b and b[c] is a
          c++
      -1

    merge: (a, c) ->
      d = c.length
      e = a.length
      f = 0
      if typeof d is "number"
        while f < d
          a[e++] = c[f]
          f++
      else
        a[e++] = c[f++]  while c[f] isnt b
      a.length = e
      a

    grep: (a, b, c) ->
      d = undefined
      e = []
      f = 0
      g = a.length
      c = !!c
      while f < g
        d = !!b(a[f], f)
        c isnt d and e.push(a[f])
        f++
      e

    map: (a, c, d) ->
      e = undefined
      f = undefined
      g = []
      h = 0
      i = a.length
      j = a instanceof p or i isnt b and typeof i is "number" and (i > 0 and a[0] and a[i - 1] or i is 0 or p.isArray(a))
      if j
        while h < i
          e = c(a[h], h, d)
          e? and (g[g.length] = e)
          h++
      else
        for f of a
          e = c(a[f], f, d)
          e? and (g[g.length] = e)
      g.concat.apply [], g

    guid: 1
    proxy: (a, c) ->
      d = undefined
      e = undefined
      f = undefined
      typeof c is "string" and (d = a[c]
      c = a
      a = d
      )
      (if p.isFunction(a) then (e = k.call(arguments_, 2)
      f = ->
        a.apply c, e.concat(k.call(arguments_))

      f.guid = a.guid = a.guid or f.guid or p.guid++
      f
      ) else b)

    access: (a, c, d, e, f, g, h) ->
      i = undefined
      j = not d?
      k = 0
      l = a.length
      if d and typeof d is "object"
        for k of d
          p.access a, c, k, d[k], 1, g, e
        f = 1
      else if e isnt b
        i = h is b and p.isFunction(e)
        j and ((if i then (i = c
        c = (a, b, c) ->
          i.call p(a), c

        ) else (c.call(a, e)
        c = null
        )))

        if c
          while k < l
            c a[k], d, (if i then e.call(a[k], k, c(a[k], d)) else e), h
            k++
        f = 1
      (if f then a else (if j then c.call(a) else (if l then c(a[0], d) else g)))

    now: ->
      (new Date).getTime()
  )
  p.ready.promise = (b) ->
    unless d
      d = p.Deferred()
      if e.readyState is "complete" or e.readyState isnt "loading" and e.addEventListener
        setTimeout p.ready, 1
      else unless e.addEventListener
        e.attachEvent("onreadystatechange", D)
        a.attachEvent("onload", p.ready)

        c = not 1
        try
          c = not a.frameElement? and e.documentElement
        c and c.doScroll and g = ->
          unless p.isReady
            try
              c.doScroll "left"
            catch a
              return setTimeout(g, 50)
            p.ready()
        ()
    d.promise b

  p.each("Boolean Number String Function Array Date RegExp Object".split(" "), (a, b) ->
    E["[object " + b + "]"] = b.toLowerCase()
  )
  c = p(e)

  F = {}
  p.Callbacks = (a) ->
    a = (if typeof a is "string" then F[a] or G(a) else p.extend({}, a))
    c = undefined
    d = undefined
    e = undefined
    f = undefined
    g = undefined
    h = undefined
    i = []
    j = not a.once and []
    k = (b) ->
      c = a.memory and b
      d = not 0
      h = f or 0
      f = 0
      g = i.length
      e = not 0

      while i and h < g
        if i[h].apply(b[0], b[1]) is not 1 and a.stopOnFalse
          c = not 1
          break
        h++
      e = not 1
      i and ((if j then j.length and k(j.shift()) else (if c then i = [] else l.disable())))

    l =
      add: ->
        if i
          b = i.length
          (d = (b) ->
            p.each b, (b, c) ->
              (if p.isFunction(c) and (not a.unique or not l.has(c)) then i.push(c) else c and c.length and d(c))

          )(arguments_)
          (if e then g = i.length else c and (f = b
          k(c)
          ))
        this

      remove: ->
        i and p.each(arguments_, (a, b) ->
          c = undefined
          while (c = p.inArray(b, i, c)) > -1
            i.splice(c, 1)
            e and (c <= g and g--
            c <= h and h--
            )
        )
        this

      has: (a) ->
        p.inArray(a, i) > -1

      empty: ->
        i = []
        this

      disable: ->
        i = j = c = b
        this

      disabled: ->
        not i

      lock: ->
        j = b
        c or l.disable()
        this

      locked: ->
        not j

      fireWith: (a, b) ->
        b = b or []
        b = [a, (if b.slice then b.slice() else b)]
        i and (not d or j) and ((if e then j.push(b) else k(b)))
        this

      fire: ->
        l.fireWith(this, arguments_)
        this

      fired: ->
        !!d

    l

  p.extend(
    Deferred: (a) ->
      b = [["resolve", "done", p.Callbacks("once memory"), "resolved"], ["reject", "fail", p.Callbacks("once memory"), "rejected"], ["notify", "progress", p.Callbacks("memory")]]
      c = "pending"
      d =
        state: ->
          c

        always: ->
          e.done(arguments_).fail(arguments_)
          this

        then: ->
          a = arguments_
          p.Deferred((c) ->
            p.each(b, (b, d) ->
              f = d[0]
              g = a[b]
              e[d[1]] (if p.isFunction(g) then ->
                a = g.apply(this, arguments_)
                (if a and p.isFunction(a.promise) then a.promise().done(c.resolve).fail(c.reject).progress(c.notify) else c[f + "With"]((if this is e then c else this), [a]))
               else c[f])
            )
            a = null
          ).promise()

        promise: (a) ->
          (if typeof a is "object" then p.extend(a, d) else d)

      e = {}
      d.pipe = d.then
      p.each(b, (a, f) ->
        g = f[2]
        h = f[3]
        d[f[1]] = g.add
        h and g.add(->
          c = h
        , b[a ^ 1][2].disable, b[2][2].lock)
        e[f[0]] = g.fire
        e[f[0] + "With"] = g.fireWith
      )
      d.promise(e)
      a and a.call(e, e)
      e

    when: (a) ->
      b = 0
      c = k.call(arguments_)
      d = c.length
      e = (if d isnt 1 or a and p.isFunction(a.promise) then d else 0)
      f = (if e is 1 then a else p.Deferred())
      g = (a, b, c) ->
        (d) ->
          b[a] = this
          c[a] = (if arguments_.length > 1 then k.call(arguments_) else d)
          (if c is h then f.notifyWith(b, c) else --e or f.resolveWith(b, c))

      h = undefined
      i = undefined
      j = undefined
      if d > 1
        h = new Array(d)
        i = new Array(d)
        j = new Array(d)

        while b < d
          (if c[b] and p.isFunction(c[b].promise) then c[b].promise().done(g(b, j, c)).fail(f.reject).progress(g(b, i, h)) else --e)
          b++
      e or f.resolveWith(j, c)
      f.promise()
  )
  p.support = ->
    b = undefined
    c = undefined
    d = undefined
    f = undefined
    g = undefined
    h = undefined
    i = undefined
    j = undefined
    k = undefined
    l = undefined
    m = undefined
    n = e.createElement("div")
    n.setAttribute("className", "t")
    n.innerHTML = "  <link/><table></table><a href='/a'>a</a><input type='checkbox'/>"
    c = n.getElementsByTagName("*")
    d = n.getElementsByTagName("a")[0]
    d.style.cssText = "top:1px;float:left;opacity:.5"

    return {}  if not c or not c.length or not d
    f = e.createElement("select")
    g = f.appendChild(e.createElement("option"))
    h = n.getElementsByTagName("input")[0]
    b =
      leadingWhitespace: n.firstChild.nodeType is 3
      tbody: not n.getElementsByTagName("tbody").length
      htmlSerialize: !!n.getElementsByTagName("link").length
      style: /top/.test(d.getAttribute("style"))
      hrefNormalized: d.getAttribute("href") is "/a"
      opacity: /^0.5/.test(d.style.opacity)
      cssFloat: !!d.style.cssFloat
      checkOn: h.value is "on"
      optSelected: g.selected
      getSetAttribute: n.className isnt "t"
      enctype: !!e.createElement("form").enctype
      html5Clone: e.createElement("nav").cloneNode(not 0).outerHTML isnt "<:nav></:nav>"
      boxModel: e.compatMode is "CSS1Compat"
      submitBubbles: not 0
      changeBubbles: not 0
      focusinBubbles: not 1
      deleteExpando: not 0
      noCloneEvent: not 0
      inlineBlockNeedsLayout: not 1
      shrinkWrapBlocks: not 1
      reliableMarginRight: not 0
      boxSizingReliable: not 0
      pixelPosition: not 1

    h.checked = not 0
    b.noCloneChecked = h.cloneNode(not 0).checked
    f.disabled = not 0
    b.optDisabled = not g.disabled

    try
      delete n.test
    catch o
      b.deleteExpando = not 1
    not n.addEventListener and n.attachEvent and n.fireEvent and (n.attachEvent("onclick", m = ->
      b.noCloneEvent = not 1
    )
    n.cloneNode(not 0).fireEvent("onclick")
    n.detachEvent("onclick", m)
    )
    h = e.createElement("input")
    h.value = "t"
    h.setAttribute("type", "radio")
    b.radioValue = h.value is "t"
    h.setAttribute("checked", "checked")
    h.setAttribute("name", "t")
    n.appendChild(h)
    i = e.createDocumentFragment()
    i.appendChild(n.lastChild)
    b.checkClone = i.cloneNode(not 0).cloneNode(not 0).lastChild.checked
    b.appendChecked = h.checked
    i.removeChild(h)
    i.appendChild(n)

    if n.attachEvent
      for k of
        submit: not 0
        change: not 0
        focusin: not 0
        j = "on" + k
        l = j of n
        l or (n.setAttribute(j, "return;")
        l = typeof n[j] is "function"
        )
        b[k + "Bubbles"] = l
    p(->
      c = undefined
      d = undefined
      f = undefined
      g = undefined
      h = "padding:0;margin:0;border:0;display:block;overflow:hidden;"
      i = e.getElementsByTagName("body")[0]
      return  unless i
      c = e.createElement("div")
      c.style.cssText = "visibility:hidden;border:0;width:0;height:0;position:static;top:0;margin-top:1px"
      i.insertBefore(c, i.firstChild)
      d = e.createElement("div")
      c.appendChild(d)
      d.innerHTML = "<table><tr><td></td><td>t</td></tr></table>"
      f = d.getElementsByTagName("td")
      f[0].style.cssText = "padding:0;margin:0;border:0;display:none"
      l = f[0].offsetHeight is 0
      f[0].style.display = ""
      f[1].style.display = "none"
      b.reliableHiddenOffsets = l and f[0].offsetHeight is 0
      d.innerHTML = ""
      d.style.cssText = "box-sizing:border-box;-moz-box-sizing:border-box;-webkit-box-sizing:border-box;padding:1px;border:1px;display:block;width:4px;margin-top:1%;position:absolute;top:1%;"
      b.boxSizing = d.offsetWidth is 4
      b.doesNotIncludeMarginInBodyOffset = i.offsetTop isnt 1
      a.getComputedStyle and (b.pixelPosition = (a.getComputedStyle(d, null) or {}).top isnt "1%"
      b.boxSizingReliable = (a.getComputedStyle(d, null) or width: "4px").width is "4px"
      g = e.createElement("div")
      g.style.cssText = d.style.cssText = h
      g.style.marginRight = g.style.width = "0"
      d.style.width = "1px"
      d.appendChild(g)
      b.reliableMarginRight = not parseFloat((a.getComputedStyle(g, null) or {}).marginRight)
      )
      typeof d.style.zoom isnt "undefined" and (d.innerHTML = ""
      d.style.cssText = h + "width:1px;padding:1px;display:inline;zoom:1"
      b.inlineBlockNeedsLayout = d.offsetWidth is 3
      d.style.display = "block"
      d.style.overflow = "visible"
      d.innerHTML = "<div></div>"
      d.firstChild.style.width = "5px"
      b.shrinkWrapBlocks = d.offsetWidth isnt 3
      c.style.zoom = 1
      )
      i.removeChild(c)
      c = d = f = g = null
    )
    i.removeChild(n)
    c = d = f = g = h = i = n = null
    b
  ()

  H = /^(?:\{.*\}|\[.*\])$/
  I = /([A-Z])/g
  p.extend(
    cache: {}
    deletedIds: []
    uuid: 0
    expando: "jQuery" + (p.fn.jquery + Math.random()).replace(/\D/g, "")
    noData:
      embed: not 0
      object: "clsid:D27CDB6E-AE6D-11cf-96B8-444553540000"
      applet: not 0

    hasData: (a) ->
      a = (if a.nodeType then p.cache[a[p.expando]] else a[p.expando])
      !!a and not K(a)

    data: (a, c, d, e) ->
      return  unless p.acceptData(a)
      f = undefined
      g = undefined
      h = p.expando
      i = typeof c is "string"
      j = a.nodeType
      k = (if j then p.cache else a)
      l = (if j then a[h] else a[h] and h)
      return  if (not l or not k[l] or not e and not k[l].data) and i and d is b
      l or ((if j then a[h] = l = p.deletedIds.pop() or ++p.uuid else l = h))
      k[l] or (k[l] = {}
      j or (k[l].toJSON = p.noop)
      )

      (if e then k[l] = p.extend(k[l], c) else k[l].data = p.extend(k[l].data, c))  if typeof c is "object" or typeof c is "function"
      f = k[l]
      e or (f.data or (f.data = {})
      f = f.data
      )
      d isnt b and (f[p.camelCase(c)] = d)
      (if i then (g = f[c]
      not g? and (g = f[p.camelCase(c)])
      ) else g = f)
      g

    removeData: (a, b, c) ->
      return  unless p.acceptData(a)
      d = undefined
      e = undefined
      f = undefined
      g = a.nodeType
      h = (if g then p.cache else a)
      i = (if g then a[p.expando] else p.expando)
      return  unless h[i]
      if b
        d = (if c then h[i] else h[i].data)
        if d
          p.isArray(b) or ((if b of d then b = [b] else (b = p.camelCase(b)
          (if b of d then b = [b] else b = b.split(" "))
          )))
          e = 0
          f = b.length

          while e < f
            delete d[b[e]]
            e++
          return  unless ((if c then K else p.isEmptyObject))(d)
      unless c
        delete h[i].data

        return  unless K(h[i])
      (if g then p.cleanData([a], not 0) else (if p.support.deleteExpando or h isnt h.window then delete h[i]
       else h[i] = null))

    _data: (a, b, c) ->
      p.data a, b, c, not 0

    acceptData: (a) ->
      b = a.nodeName and p.noData[a.nodeName.toLowerCase()]
      not b or b isnt not 0 and a.getAttribute("classid") is b
  )
  p.fn.extend(
    data: (a, c) ->
      d = undefined
      e = undefined
      f = undefined
      g = undefined
      h = undefined
      i = this[0]
      j = 0
      k = null
      if a is b
        if @length
          k = p.data(i)
          if i.nodeType is 1 and not p._data(i, "parsedAttrs")
            f = i.attributes
            h = f.length
            while j < h
              g = f[j].name
              g.indexOf("data-") is 0 and (g = p.camelCase(g.substring(5))
              J(i, g, k[g])
              )
              j++
            p._data i, "parsedAttrs", not 0
        return k
      (if typeof a is "object" then @each(->
        p.data this, a
      ) else (d = a.split(".", 2)
      d[1] = (if d[1] then "." + d[1] else "")
      e = d[1] + "!"
      p.access(this, (c) ->
        if c is b
          return k = @triggerHandler("getData" + e, [d[0]])
          k is b and i and (k = p.data(i, a)
          k = J(i, a, k)
          )
          (if k is b and d[1] then @data(d[0]) else k)
        d[1] = c
        @each(->
          b = p(this)
          b.triggerHandler("setData" + e, d)
          p.data(this, a, c)
          b.triggerHandler("changeData" + e, d)
        )
      , null, c, arguments_.length > 1, null, not 1)
      ))

    removeData: (a) ->
      @each ->
        p.removeData this, a

  )
  p.extend(
    queue: (a, b, c) ->
      d = undefined
      if a
        b = (b or "fx") + "queue"
        d = p._data(a, b)
        c and ((if not d or p.isArray(c) then d = p._data(a, b, p.makeArray(c)) else d.push(c)))
        d or []

    dequeue: (a, b) ->
      b = b or "fx"
      c = p.queue(a, b)
      d = c.shift()
      e = p._queueHooks(a, b)
      f = ->
        p.dequeue a, b

      d is "inprogress" and (d = c.shift())
      d and (b is "fx" and c.unshift("inprogress")
      delete e.stop

      d.call(a, f, e)
      )
      not c.length and e and e.empty.fire()

    _queueHooks: (a, b) ->
      c = b + "queueHooks"
      p._data(a, c) or p._data(a, c,
        empty: p.Callbacks("once memory").add(->
          p.removeData(a, b + "queue", not 0)
          p.removeData(a, c, not 0)
        )
      )
  )
  p.fn.extend(
    queue: (a, c) ->
      d = 2
      typeof a isnt "string" and (c = a
      a = "fx"
      d--
      )
      (if arguments_.length < d then p.queue(this[0], a) else (if c is b then this else @each(->
        b = p.queue(this, a, c)
        p._queueHooks(this, a)
        a is "fx" and b[0] isnt "inprogress" and p.dequeue(this, a)
      )))

    dequeue: (a) ->
      @each ->
        p.dequeue this, a


    delay: (a, b) ->
      a = (if p.fx then p.fx.speeds[a] or a else a)
      b = b or "fx"
      @queue(b, (b, c) ->
        d = setTimeout(b, a)
        c.stop = ->
          clearTimeout d
      )

    clearQueue: (a) ->
      @queue a or "fx", []

    promise: (a, c) ->
      d = undefined
      e = 1
      f = p.Deferred()
      g = this
      h = @length
      i = ->
        --e or f.resolveWith(g, [g])

      typeof a isnt "string" and (c = a
      a = b
      )
      a = a or "fx"

      while h--
        (d = p._data(g[h], a + "queueHooks")) and d.empty and (e++
        d.empty.add(i)
        )
      i()
      f.promise(c)
  )

  L = undefined
  M = undefined
  N = undefined
  O = /[\t\r\n]/g
  P = /\r/g
  Q = /^(?:button|input)$/i
  R = /^(?:button|input|object|select|textarea)$/i
  S = /^a(?:rea|)$/i
  T = /^(?:autofocus|autoplay|async|checked|controls|defer|disabled|hidden|loop|multiple|open|readonly|required|scoped|selected)$/i
  U = p.support.getSetAttribute
  p.fn.extend(
    attr: (a, b) ->
      p.access this, p.attr, a, b, arguments_.length > 1

    removeAttr: (a) ->
      @each ->
        p.removeAttr this, a


    prop: (a, b) ->
      p.access this, p.prop, a, b, arguments_.length > 1

    removeProp: (a) ->
      a = p.propFix[a] or a
      @each(->
        try
          this[a] = b
          delete this[a]
      )

    addClass: (a) ->
      b = undefined
      c = undefined
      d = undefined
      e = undefined
      f = undefined
      g = undefined
      h = undefined
      if p.isFunction(a)
        return @each((b) ->
          p(this).addClass a.call(this, b, @className)
        )
      if a and typeof a is "string"
        b = a.split(s)
        c = 0
        d = @length

        while c < d
          e = this[c]
          if e.nodeType is 1
            unless not e.className and b.length is 1
              f = " " + e.className + " "
              g = 0
              h = b.length

              while g < h
                ~f.indexOf(" " + b[g] + " ") or (f += b[g] + " ")
                g++
              e.className = p.trim(f)
          c++
      this

    removeClass: (a) ->
      c = undefined
      d = undefined
      e = undefined
      f = undefined
      g = undefined
      h = undefined
      i = undefined
      if p.isFunction(a)
        return @each((b) ->
          p(this).removeClass a.call(this, b, @className)
        )
      if a and typeof a is "string" or a is b
        c = (a or "").split(s)
        h = 0
        i = @length

        while h < i
          e = this[h]
          if e.nodeType is 1 and e.className
            d = (" " + e.className + " ").replace(O, " ")
            f = 0
            g = c.length

            while f < g
              d = d.replace(" " + c[f] + " ", " ")  while d.indexOf(" " + c[f] + " ") > -1
              f++
            e.className = (if a then p.trim(d) else "")
          h++
      this

    toggleClass: (a, b) ->
      c = typeof a
      d = typeof b is "boolean"
      (if p.isFunction(a) then @each((c) ->
        p(this).toggleClass a.call(this, c, @className, b), b
      ) else @each(->
        if c is "string"
          e = undefined
          f = 0
          g = p(this)
          h = b
          i = a.split(s)
          while e = i[f++]
            h = (if d then h else not g.hasClass(e))
            g[(if h then "addClass" else "removeClass")](e)
        else if c is "undefined" or c is "boolean"
          @className and p._data(this, "__className__", @className)
          @className = (if @className or a is not 1 then "" else p._data(this, "__className__") or "")
      ))

    hasClass: (a) ->
      b = " " + a + " "
      c = 0
      d = @length
      while c < d
        return not 0  if this[c].nodeType is 1 and (" " + this[c].className + " ").replace(O, " ").indexOf(b) > -1
        c++
      not 1

    val: (a) ->
      c = undefined
      d = undefined
      e = undefined
      f = this[0]
      unless arguments_.length
        if f
          return c = p.valHooks[f.type] or p.valHooks[f.nodeName.toLowerCase()]
          (if c and "get" of c and (d = c.get(f, "value")) isnt b then d else (d = f.value
          (if typeof d is "string" then d.replace(P, "") else (if not d? then "" else d))
          ))
        return
      e = p.isFunction(a)
      @each((d) ->
        f = undefined
        g = p(this)
        return  if @nodeType isnt 1
        (if e then f = a.call(this, d, g.val()) else f = a)
        (if not f? then f = "" else (if typeof f is "number" then f += "" else p.isArray(f) and (f = p.map(f, (a) ->
          (if not a? then "" else a + "")
        ))))
        c = p.valHooks[@type] or p.valHooks[@nodeName.toLowerCase()]

        @value = f  if not c or ("set" not of c) or c.set(this, f, "value") is b
      )
  )
  p.extend(
    valHooks:
      option:
        get: (a) ->
          b = a.attributes.value
          (if not b or b.specified then a.value else a.text)

      select:
        get: (a) ->
          b = undefined
          c = undefined
          d = undefined
          e = undefined
          f = a.selectedIndex
          g = []
          h = a.options
          i = a.type is "select-one"
          return null  if f < 0
          c = (if i then f else 0)
          d = (if i then f + 1 else h.length)

          while c < d
            e = h[c]
            if e.selected and ((if p.support.optDisabled then not e.disabled else e.getAttribute("disabled") is null)) and (not e.parentNode.disabled or not p.nodeName(e.parentNode, "optgroup"))
              b = p(e).val()
              return b  if i
              g.push b
            c++
          (if i and not g.length and h.length then p(h[f]).val() else g)

        set: (a, b) ->
          c = p.makeArray(b)
          p(a).find("option").each(->
            @selected = p.inArray(p(this).val(), c) >= 0
          )
          c.length or (a.selectedIndex = -1)
          c

    attrFn: {}
    attr: (a, c, d, e) ->
      f = undefined
      g = undefined
      h = undefined
      i = a.nodeType
      return  if not a or i is 3 or i is 8 or i is 2
      return p(a)[c](d)  if e and p.isFunction(p.fn[c])
      return p.prop(a, c, d)  if typeof a.getAttribute is "undefined"
      h = i isnt 1 or not p.isXMLDoc(a)
      h and (c = c.toLowerCase()
      g = p.attrHooks[c] or ((if T.test(c) then M else L))
      )

      if d isnt b
        if d is null
          p.removeAttr a, c
          return
        return (if g and "set" of g and h and (f = g.set(a, d, c)) isnt b then f else (a.setAttribute(c, "" + d)
        d
        ))
      (if g and "get" of g and h and (f = g.get(a, c)) isnt null then f else (f = a.getAttribute(c)
      (if f is null then b else f)
      ))

    removeAttr: (a, b) ->
      c = undefined
      d = undefined
      e = undefined
      f = undefined
      g = 0
      if b and a.nodeType is 1
        d = b.split(s)
        while g < d.length
          e = d[g]
          e and (c = p.propFix[e] or e
          f = T.test(e)
          f or p.attr(a, e, "")
          a.removeAttribute((if U then e else c))
          f and c of a and (a[c] = not 1)
          )
          g++

    attrHooks:
      type:
        set: (a, b) ->
          if Q.test(a.nodeName) and a.parentNode
            p.error "type property can't be changed"
          else if not p.support.radioValue and b is "radio" and p.nodeName(a, "input")
            c = a.value
            a.setAttribute("type", b)
            c and (a.value = c)
            b

      value:
        get: (a, b) ->
          (if L and p.nodeName(a, "button") then L.get(a, b) else (if b of a then a.value else null))

        set: (a, b, c) ->
          return L.set(a, b, c)  if L and p.nodeName(a, "button")
          a.value = b

    propFix:
      tabindex: "tabIndex"
      readonly: "readOnly"
      for: "htmlFor"
      class: "className"
      maxlength: "maxLength"
      cellspacing: "cellSpacing"
      cellpadding: "cellPadding"
      rowspan: "rowSpan"
      colspan: "colSpan"
      usemap: "useMap"
      frameborder: "frameBorder"
      contenteditable: "contentEditable"

    prop: (a, c, d) ->
      e = undefined
      f = undefined
      g = undefined
      h = a.nodeType
      return  if not a or h is 3 or h is 8 or h is 2
      g = h isnt 1 or not p.isXMLDoc(a)
      g and (c = p.propFix[c] or c
      f = p.propHooks[c]
      )
      (if d isnt b then (if f and "set" of f and (e = f.set(a, d, c)) isnt b then e else a[c] = d) else (if f and "get" of f and (e = f.get(a, c)) isnt null then e else a[c]))

    propHooks:
      tabIndex:
        get: (a) ->
          c = a.getAttributeNode("tabindex")
          (if c and c.specified then parseInt(c.value, 10) else (if R.test(a.nodeName) or S.test(a.nodeName) and a.href then 0 else b))
  )
  M =
    get: (a, c) ->
      d = undefined
      e = p.prop(a, c)
      (if e is not 0 or typeof e isnt "boolean" and (d = a.getAttributeNode(c)) and d.nodeValue isnt not 1 then c.toLowerCase() else b)

    set: (a, b, c) ->
      d = undefined
      (if b is not 1 then p.removeAttr(a, c) else (d = p.propFix[c] or c
      d of a and (a[d] = not 0)
      a.setAttribute(c, c.toLowerCase())
      ))
      c

  U or (N =
    name: not 0
    id: not 0
    coords: not 0

  L = p.valHooks.button =
    get: (a, c) ->
      d = undefined
      d = a.getAttributeNode(c)
      (if d and ((if N[c] then d.value isnt "" else d.specified)) then d.value else b)

    set: (a, b, c) ->
      d = a.getAttributeNode(c)
      d or (d = e.createAttribute(c)
      a.setAttributeNode(d)
      )
      d.value = b + ""

  p.each(["width", "height"], (a, b) ->
    p.attrHooks[b] = p.extend(p.attrHooks[b],
      set: (a, c) ->
        if c is ""
          a.setAttribute(b, "auto")
          c
    )
  )
  p.attrHooks.contenteditable =
    get: L.get
    set: (a, b, c) ->
      b is "" and (b = "false")
      L.set(a, b, c)

  )
  p.support.hrefNormalized or p.each(["href", "src", "width", "height"], (a, c) ->
    p.attrHooks[c] = p.extend(p.attrHooks[c],
      get: (a) ->
        d = a.getAttribute(c, 2)
        (if d is null then b else d)
    )
  )
  p.support.style or (p.attrHooks.style =
    get: (a) ->
      a.style.cssText.toLowerCase() or b

    set: (a, b) ->
      a.style.cssText = "" + b
  )
  p.support.optSelected or (p.propHooks.selected = p.extend(p.propHooks.selected,
    get: (a) ->
      b = a.parentNode
      b and (b.selectedIndex
      b.parentNode and b.parentNode.selectedIndex
      )
      null
  ))
  p.support.enctype or (p.propFix.enctype = "encoding")
  p.support.checkOn or p.each(["radio", "checkbox"], ->
    p.valHooks[this] = get: (a) ->
      (if a.getAttribute("value") is null then "on" else a.value)
  )
  p.each(["radio", "checkbox"], ->
    p.valHooks[this] = p.extend(p.valHooks[this],
      set: (a, b) ->
        a.checked = p.inArray(p(a).val(), b) >= 0  if p.isArray(b)
    )
  )

  V = /^(?:textarea|input|select)$/i
  W = /^([^\.]*|)(?:\.(.+)|)$/
  X = /(?:^|\s)hover(\.\S+|)\b/
  Y = /^key/
  Z = /^(?:mouse|contextmenu)|click/
  $ = /^(?:focusinfocus|focusoutblur)$/
  _ = (a) ->
    (if p.event.special.hover then a else a.replace(X, "mouseenter$1 mouseleave$1"))

  p.event =
    add: (a, c, d, e, f) ->
      g = undefined
      h = undefined
      i = undefined
      j = undefined
      k = undefined
      l = undefined
      m = undefined
      n = undefined
      o = undefined
      q = undefined
      r = undefined
      return  if a.nodeType is 3 or a.nodeType is 8 or not c or not d or not (g = p._data(a))
      d.handler and (o = d
      d = o.handler
      f = o.selector
      )
      d.guid or (d.guid = p.guid++)
      i = g.events
      i or (g.events = i = {})
      h = g.handle
      h or (g.handle = h = (a) ->
        (if typeof p isnt "undefined" and (not a or p.event.triggered isnt a.type) then p.event.dispatch.apply(h.elem, arguments_) else b)

      h.elem = a
      )
      c = p.trim(_(c)).split(" ")

      j = 0
      while j < c.length
        k = W.exec(c[j]) or []
        l = k[1]
        m = (k[2] or "").split(".").sort()
        r = p.event.special[l] or {}
        l = ((if f then r.delegateType else r.bindType)) or l
        r = p.event.special[l] or {}
        n = p.extend(
          type: l
          origType: k[1]
          data: e
          handler: d
          guid: d.guid
          selector: f
          namespace: m.join(".")
        , o)
        q = i[l]

        unless q
          q = i[l] = []
          q.delegateCount = 0

          (if a.addEventListener then a.addEventListener(l, h, not 1) else a.attachEvent and a.attachEvent("on" + l, h))  if not r.setup or r.setup.call(a, e, m, h) is not 1
        r.add and (r.add.call(a, n)
        n.handler.guid or (n.handler.guid = d.guid)
        )
        (if f then q.splice(q.delegateCount++, 0, n) else q.push(n))
        p.event.global[l] = not 0
        j++
      a = null

    global: {}
    remove: (a, b, c, d, e) ->
      f = undefined
      g = undefined
      h = undefined
      i = undefined
      j = undefined
      k = undefined
      l = undefined
      m = undefined
      n = undefined
      o = undefined
      q = undefined
      r = p.hasData(a) and p._data(a)
      return  if not r or not (m = r.events)
      b = p.trim(_(b or "")).split(" ")
      f = 0
      while f < b.length
        g = W.exec(b[f]) or []
        h = i = g[1]
        j = g[2]

        unless h
          for h of m
            p.event.remove a, h + b[f], c, d, not 0
          continue
        n = p.event.special[h] or {}
        h = ((if d then n.delegateType else n.bindType)) or h
        o = m[h] or []
        k = o.length
        j = (if j then new RegExp("(^|\\.)" + j.split(".").sort().join("\\.(?:.*\\.|)") + "(\\.|$)") else null)

        l = 0
        while l < o.length
          q = o[l]
          (e or i is q.origType) and (not c or c.guid is q.guid) and (not j or j.test(q.namespace)) and (not d or d is q.selector or d is "**" and q.selector) and (o.splice(l--, 1)
          q.selector and o.delegateCount--
          n.remove and n.remove.call(a, q)
          )
          l++
        o.length is 0 and k isnt o.length and ((not n.teardown or n.teardown.call(a, j, r.handle) is not 1) and p.removeEvent(a, h, r.handle)
        delete m[h]

        )
        f++
      p.isEmptyObject(m) and (delete r.handle

      p.removeData(a, "events", not 0)
      )

    customEvent:
      getData: not 0
      setData: not 0
      changeData: not 0

    trigger: (c, d, f, g) ->
      if not f or f.nodeType isnt 3 and f.nodeType isnt 8
        h = undefined
        i = undefined
        j = undefined
        k = undefined
        l = undefined
        m = undefined
        n = undefined
        o = undefined
        q = undefined
        r = undefined
        s = c.type or c
        t = []
        return  if $.test(s + p.event.triggered)
        s.indexOf("!") >= 0 and (s = s.slice(0, -1)
        i = not 0
        )
        s.indexOf(".") >= 0 and (t = s.split(".")
        s = t.shift()
        t.sort()
        )

        return  if (not f or p.event.customEvent[s]) and not p.event.global[s]
        c = (if typeof c is "object" then (if c[p.expando] then c else new p.Event(s, c)) else new p.Event(s))
        c.type = s
        c.isTrigger = not 0
        c.exclusive = i
        c.namespace = t.join(".")
        c.namespace_re = (if c.namespace then new RegExp("(^|\\.)" + t.join("\\.(?:.*\\.|)") + "(\\.|$)") else null)
        m = (if s.indexOf(":") < 0 then "on" + s else "")

        unless f
          h = p.cache
          for j of h
            h[j].events and h[j].events[s] and p.event.trigger(c, d, h[j].handle.elem, not 0)
          return
        c.result = b
        c.target or (c.target = f)
        d = (if d? then p.makeArray(d) else [])
        d.unshift(c)
        n = p.event.special[s] or {}

        return  if n.trigger and n.trigger.apply(f, d) is not 1
        q = [[f, n.bindType or s]]
        if not g and not n.noBubble and not p.isWindow(f)
          r = n.delegateType or s
          k = (if $.test(r + s) then f else f.parentNode)

          l = f
          while k
            q.push([k, r])
            l = k
            k = k.parentNode
          l is (f.ownerDocument or e) and q.push([l.defaultView or l.parentWindow or a, r])
        j = 0
        while j < q.length and not c.isPropagationStopped()
          k = q[j][0]
          c.type = q[j][1]
          o = (p._data(k, "events") or {})[c.type] and p._data(k, "handle")
          o and o.apply(k, d)
          o = m and k[m]
          o and p.acceptData(k) and o.apply(k, d) is not 1 and c.preventDefault()
          j++
        return c.type = s
        not g and not c.isDefaultPrevented() and (not n._default or n._default.apply(f.ownerDocument, d) is not 1) and (s isnt "click" or not p.nodeName(f, "a")) and p.acceptData(f) and m and f[s] and (s isnt "focus" and s isnt "blur" or c.target.offsetWidth isnt 0) and not p.isWindow(f) and (l = f[m]
        l and (f[m] = null)
        p.event.triggered = s
        f[s]()
        p.event.triggered = b
        l and (f[m] = l)
        )
        c.result
      return

    dispatch: (c) ->
      c = p.event.fix(c or a.event)
      d = undefined
      e = undefined
      f = undefined
      g = undefined
      h = undefined
      i = undefined
      j = undefined
      k = undefined
      l = undefined
      m = undefined
      n = undefined
      o = (p._data(this, "events") or {})[c.type] or []
      q = o.delegateCount
      r = [].slice.call(arguments_)
      s = not c.exclusive and not c.namespace
      t = p.event.special[c.type] or {}
      u = []
      r[0] = c
      c.delegateTarget = this

      return  if t.preDispatch and t.preDispatch.call(this, c) is not 1
      if q and (not c.button or c.type isnt "click")
        g = p(this)
        g.context = this

        f = c.target
        while f isnt this
          if f.disabled isnt not 0 or c.type isnt "click"
            i = {}
            k = []
            g[0] = f

            d = 0
            while d < q
              l = o[d]
              m = l.selector
              i[m] is b and (i[m] = g.is(m))
              i[m] and k.push(l)
              d++
            k.length and u.push(
              elem: f
              matches: k
            )
          f = f.parentNode or this
      o.length > q and u.push(
        elem: this
        matches: o.slice(q)
      )
      d = 0
      while d < u.length and not c.isPropagationStopped()
        j = u[d]
        c.currentTarget = j.elem

        e = 0
        while e < j.matches.length and not c.isImmediatePropagationStopped()
          l = j.matches[e]
          if s or not c.namespace and not l.namespace or c.namespace_re and c.namespace_re.test(l.namespace)
            c.data = l.data
            c.handleObj = l
            h = ((p.event.special[l.origType] or {}).handle or l.handler).apply(j.elem, r)
            h isnt b and (c.result = h
            h is not 1 and (c.preventDefault()
            c.stopPropagation()
            )
            )
          e++
        d++
      t.postDispatch and t.postDispatch.call(this, c)
      c.result

    props: "attrChange attrName relatedNode srcElement altKey bubbles cancelable ctrlKey currentTarget eventPhase metaKey relatedTarget shiftKey target timeStamp view which".split(" ")
    fixHooks: {}
    keyHooks:
      props: "char charCode key keyCode".split(" ")
      filter: (a, b) ->
        not a.which? and (a.which = (if b.charCode? then b.charCode else b.keyCode))
        a

    mouseHooks:
      props: "button buttons clientX clientY fromElement offsetX offsetY pageX pageY screenX screenY toElement".split(" ")
      filter: (a, c) ->
        d = undefined
        f = undefined
        g = undefined
        h = c.button
        i = c.fromElement
        not a.pageX? and c.clientX? and (d = a.target.ownerDocument or e
        f = d.documentElement
        g = d.body
        a.pageX = c.clientX + (f and f.scrollLeft or g and g.scrollLeft or 0) - (f and f.clientLeft or g and g.clientLeft or 0)
        a.pageY = c.clientY + (f and f.scrollTop or g and g.scrollTop or 0) - (f and f.clientTop or g and g.clientTop or 0)
        )
        not a.relatedTarget and i and (a.relatedTarget = (if i is a.target then c.toElement else i))
        not a.which and h isnt b and (a.which = (if h & 1 then 1 else (if h & 2 then 3 else (if h & 4 then 2 else 0))))
        a

    fix: (a) ->
      return a  if a[p.expando]
      b = undefined
      c = undefined
      d = a
      f = p.event.fixHooks[a.type] or {}
      g = (if f.props then @props.concat(f.props) else @props)
      a = p.Event(d)
      b = g.length
      while b
        c = g[--b]
        a[c] = d[c]
      a.target or (a.target = d.srcElement or e)
      a.target.nodeType is 3 and (a.target = a.target.parentNode)
      a.metaKey = !!a.metaKey
      (if f.filter then f.filter(a, d) else a)

    special:
      ready:
        setup: p.bindReady

      load:
        noBubble: not 0

      focus:
        delegateType: "focusin"

      blur:
        delegateType: "focusout"

      beforeunload:
        setup: (a, b, c) ->
          p.isWindow(this) and (@onbeforeunload = c)

        teardown: (a, b) ->
          @onbeforeunload is b and (@onbeforeunload = null)

    simulate: (a, b, c, d) ->
      e = p.extend(new p.Event, c,
        type: a
        isSimulated: not 0
        originalEvent: {}
      )
      (if d then p.event.trigger(e, null, b) else p.event.dispatch.call(b, e))
      e.isDefaultPrevented() and c.preventDefault()

  p.event.handle = p.event.dispatch
  p.removeEvent = (if e.removeEventListener then (a, b, c) ->
    a.removeEventListener and a.removeEventListener(b, c, not 1)
   else (a, b, c) ->
    d = "on" + b
    a.detachEvent and (typeof a[d] is "undefined" and (a[d] = null)
    a.detachEvent(d, c)
    )
  )
  p.Event = (a, b) ->
    if this instanceof p.Event
      (if a and a.type then (@originalEvent = a
      @type = a.type
      @isDefaultPrevented = (if a.defaultPrevented or a.returnValue is not 1 or a.getPreventDefault and a.getPreventDefault() then bb else ba)
      ) else @type = a)
      b and p.extend(this, b)
      @timeStamp = a and a.timeStamp or p.now()
      this[p.expando] = not 0
    else
      new p.Event(a, b)

  p.Event:: =
    preventDefault: ->
      @isDefaultPrevented = bb
      a = @originalEvent
      return  unless a
      (if a.preventDefault then a.preventDefault() else a.returnValue = not 1)

    stopPropagation: ->
      @isPropagationStopped = bb
      a = @originalEvent
      return  unless a
      a.stopPropagation and a.stopPropagation()
      a.cancelBubble = not 0

    stopImmediatePropagation: ->
      @isImmediatePropagationStopped = bb
      @stopPropagation()

    isDefaultPrevented: ba
    isPropagationStopped: ba
    isImmediatePropagationStopped: ba

  p.each(
    mouseenter: "mouseover"
    mouseleave: "mouseout"
  , (a, b) ->
    p.event.special[a] =
      delegateType: b
      bindType: b
      handle: (a) ->
        c = undefined
        d = this
        e = a.relatedTarget
        f = a.handleObj
        g = f.selector
        if not e or e isnt d and not p.contains(d, e)
          a.type = f.origType
          c = f.handler.apply(this, arguments_)
          a.type = b
        c
  )
  p.support.submitBubbles or (p.event.special.submit =
    setup: ->
      return not 1  if p.nodeName(this, "form")
      p.event.add this, "click._submit keypress._submit", (a) ->
        c = a.target
        d = (if p.nodeName(c, "input") or p.nodeName(c, "button") then c.form else b)
        d and not p._data(d, "_submit_attached") and (p.event.add(d, "submit._submit", (a) ->
          a._submit_bubble = not 0
        )
        p._data(d, "_submit_attached", not 0)
        )


    postDispatch: (a) ->
      a._submit_bubble and (delete a._submit_bubble

      @parentNode and not a.isTrigger and p.event.simulate("submit", @parentNode, a, not 0)
      )

    teardown: ->
      return not 1  if p.nodeName(this, "form")
      p.event.remove this, "._submit"
  )
  p.support.changeBubbles or (p.event.special.change =
    setup: ->
      if V.test(@nodeName)
        if @type is "checkbox" or @type is "radio"
          p.event.add(this, "propertychange._change", (a) ->
            a.originalEvent.propertyName is "checked" and (@_just_changed = not 0)
          )
          p.event.add(this, "click._change", (a) ->
            @_just_changed and not a.isTrigger and (@_just_changed = not 1)
            p.event.simulate("change", this, a, not 0)
          )
        return not 1
      p.event.add this, "beforeactivate._change", (a) ->
        b = a.target
        V.test(b.nodeName) and not p._data(b, "_change_attached") and (p.event.add(b, "change._change", (a) ->
          @parentNode and not a.isSimulated and not a.isTrigger and p.event.simulate("change", @parentNode, a, not 0)
        )
        p._data(b, "_change_attached", not 0)
        )


    handle: (a) ->
      b = a.target
      a.handleObj.handler.apply this, arguments_  if this isnt b or a.isSimulated or a.isTrigger or b.type isnt "radio" and b.type isnt "checkbox"

    teardown: ->
      p.event.remove(this, "._change")
      V.test(@nodeName)
  )
  p.support.focusinBubbles or p.each(
    focus: "focusin"
    blur: "focusout"
  , (a, b) ->
    c = 0
    d = (a) ->
      p.event.simulate b, a.target, p.event.fix(a), not 0

    p.event.special[b] =
      setup: ->
        c++ is 0 and e.addEventListener(a, d, not 0)

      teardown: ->
        --c is 0 and e.removeEventListener(a, d, not 0)
  )
  p.fn.extend(
    on: (a, c, d, e, f) ->
      g = undefined
      h = undefined
      if typeof a is "object"
        typeof c isnt "string" and (d = d or c
        c = b
        )
        for h of a
          @on h, c, d, a[h], f
        return this
      (if not d? and not e? then (e = c
      d = c = b
      ) else not e? and ((if typeof c is "string" then (e = d
      d = b
      ) else (e = d
      d = c
      c = b
      ))))
      if e is not 1
        e = ba
      else return this  unless e
      f is 1 and (g = e
      e = (a) ->
        p().off(a)
        g.apply(this, arguments_)

      e.guid = g.guid or (g.guid = p.guid++)
      )
      @each(->
        p.event.add this, a, e, d, c
      )

    one: (a, b, c, d) ->
      @on a, b, c, d, 1

    off: (a, c, d) ->
      e = undefined
      f = undefined
      if a and a.preventDefault and a.handleObj
        return e = a.handleObj
        p(a.delegateTarget).off((if e.namespace then e.origType + "." + e.namespace else e.origType), e.selector, e.handler)
        this
      if typeof a is "object"
        for f of a
          @off f, c, a[f]
        return this
      if c is not 1 or typeof c is "function"
        d = c
        c = b
      d is not 1 and (d = ba)
      @each(->
        p.event.remove this, a, d, c
      )

    bind: (a, b, c) ->
      @on a, null, b, c

    unbind: (a, b) ->
      @off a, null, b

    live: (a, b, c) ->
      p(@context).on(a, @selector, b, c)
      this

    die: (a, b) ->
      p(@context).off(a, @selector or "**", b)
      this

    delegate: (a, b, c, d) ->
      @on b, a, c, d

    undelegate: (a, b, c) ->
      (if arguments_.length is 1 then @off(a, "**") else @off(b, a or "**", c))

    trigger: (a, b) ->
      @each ->
        p.event.trigger a, b, this


    triggerHandler: (a, b) ->
      p.event.trigger a, b, this[0], not 0  if this[0]

    toggle: (a) ->
      b = arguments_
      c = a.guid or p.guid++
      d = 0
      e = (c) ->
        e = (p._data(this, "lastToggle" + a.guid) or 0) % d
        p._data(this, "lastToggle" + a.guid, e + 1)
        c.preventDefault()
        b[e].apply(this, arguments_) or not 1

      e.guid = c
      b[d++].guid = c  while d < b.length
      @click e

    hover: (a, b) ->
      @mouseenter(a).mouseleave b or a
  )
  p.each("blur focus focusin focusout load resize scroll unload click dblclick mousedown mouseup mousemove mouseover mouseout mouseenter mouseleave change select submit keydown keypress keyup error contextmenu".split(" "), (a, b) ->
    p.fn[b] = (a, c) ->
      not c? and (c = a
      a = null
      )
      (if arguments_.length > 0 then @on(b, null, a, c) else @trigger(b))

    Y.test(b) and (p.event.fixHooks[b] = p.event.keyHooks)
    Z.test(b) and (p.event.fixHooks[b] = p.event.mouseHooks)
  )
  (a, b) ->
    bd = (a, b, c, d) ->
      e = 0
      f = b.length
      while e < f
        Z a, b[e], c, d
        e++
    be = (a, b, c, d, e, f) ->
      g = undefined
      h = $.setFilters[b.toLowerCase()]
      h or Z.error(b)
      (a or not (g = e)) and bd(a or "*", d, g = [], e)
      (if g.length > 0 then h(g, c, f) else [])
    bf = (a, c, d, e, f) ->
      g = undefined
      h = undefined
      i = undefined
      j = undefined
      k = undefined
      l = undefined
      m = undefined
      n = undefined
      p = 0
      q = f.length
      s = L.POS
      t = new RegExp("^" + s.source + "(?!" + r + ")", "i")
      u = ->
        a = 1
        c = arguments_.length - 2
        while a < c
          arguments_[a] is b and (g[a] = b)
          a++

      while p < q
        s.exec("")
        a = f[p]
        j = []
        i = 0
        k = e

        while g = s.exec(a)
          n = s.lastIndex = g.index + g[0].length
          if n > i
            m = a.slice(i, g.index)
            i = n
            l = [c]
            B.test(m) and (k and (l = k)
            k = e
            )

            m = m.slice(0, -5).replace(B, "$&*")  if h = H.test(m)
            g.length > 1 and g[0].replace(t, u)
            k = be(m, g[1], g[2], l, k, h)
        (if k then (j = j.concat(k)
        (if (m = a.slice(i)) and m isnt ")" then (if B.test(m) then bd(m, j, d, e) else Z(m, c, d, (if e then e.concat(k) else k))) else o.apply(d, j))
        ) else Z(a, c, d, e))
        p++
      (if q is 1 then d else Z.uniqueSort(d))
    bg = (a, b, c) ->
      d = undefined
      e = undefined
      f = undefined
      g = []
      i = 0
      j = D.exec(a)
      k = not j.pop() and not j.pop()
      l = k and a.match(C) or [""]
      m = $.preFilter
      n = $.filter
      o = not c and b isnt h
      while (e = l[i])? and k
        g.push(d = [])
        o and (e = " " + e)

        while e
          k = not 1
          if j = B.exec(e)
            e = e.slice(j[0].length)
            k = d.push(
              part: j.pop().replace(A, " ")
              captures: j
            )
          for f of n
            (j = L[f].exec(e)) and (not m[f] or (j = m[f](j, b, c))) and (e = e.slice(j.shift().length)
            k = d.push(
              part: f
              captures: j
            )
            )
          break  unless k
        i++
      k or Z.error(a)
      g
    bh = (a, b, e) ->
      f = b.dir
      g = m++
      a or (a = (a) ->
        a is e
      )
      (if b.first then (b, c) ->
        return a(b, c) and b  if b.nodeType is 1  while b = b[f]
       else (b, e) ->
        h = undefined
        i = g + "." + d
        j = i + "." + c
        while b = b[f]
          if b.nodeType is 1
            return b.sizset  if (h = b[q]) is j
            if typeof h is "string" and h.indexOf(i) is 0
              return b  if b.sizset
            else
              b[q] = j
              if a(b, e)
                return b.sizset = not 0
                b
              b.sizset = not 1
      )
    bi = (a, b) ->
      (if a then (c, d) ->
        e = b(c, d)
        e and a((if e is not 0 then c else e), d)
       else b)
    bj = (a, b, c) ->
      d = undefined
      e = undefined
      f = 0
      while d = a[f]
        (if $.relative[d.part] then e = bh(e, $.relative[d.part], b) else (d.captures.push(b, c)
        e = bi(e, $.filter[d.part].apply(null, d.captures))
        ))
        f++
      e
    bk = (a) ->
      (b, c) ->
        d = undefined
        e = 0
        while d = a[e]
          return not 0  if d(b, c)
          e++
        not 1
    c = undefined
    d = undefined
    e = undefined
    f = undefined
    g = undefined
    h = a.document
    i = h.documentElement
    j = "undefined"
    k = not 1
    l = not 0
    m = 0
    n = [].slice
    o = [].push
    q = ("sizcache" + Math.random()).replace(".", "")
    r = "[\\x20\\t\\r\\n\\f]"
    s = "(?:\\\\.|[-\\w]|[^\\x00-\\xa0])+"
    t = s.replace("w", "w#")
    u = "([*^$|!~]?=)"
    v = "\\[" + r + "*(" + s + ")" + r + "*(?:" + u + r + "*(?:(['\"])((?:\\\\.|[^\\\\])*?)\\3|(" + t + ")|)|)" + r + "*\\]"
    w = ":(" + s + ")(?:\\((?:(['\"])((?:\\\\.|[^\\\\])*?)\\2|((?:[^,]|\\\\,|(?:,(?=[^\\[]*\\]))|(?:,(?=[^\\(]*\\))))*))\\)|)"
    x = ":(nth|eq|gt|lt|first|last|even|odd)(?:\\((\\d*)\\)|)(?=[^-]|$)"
    y = r + "*([\\x20\\t\\r\\n\\f>+~])" + r + "*"
    z = "(?=[^\\x20\\t\\r\\n\\f])(?:\\\\.|" + v + "|" + w.replace(2, 7) + "|[^\\\\(),])+"
    A = new RegExp("^" + r + "+|((?:^|[^\\\\])(?:\\\\.)*)" + r + "+$", "g")
    B = new RegExp("^" + y)
    C = new RegExp(z + "?(?=" + r + "*,|$)", "g")
    D = new RegExp("^(?:(?!,)(?:(?:^|,)" + r + "*" + z + ")*?|" + r + "*(.*?))(\\)|$)")
    E = new RegExp(z.slice(19, -6) + "\\x20\\t\\r\\n\\f>+~])+|" + y, "g")
    F = /^(?:#([\w\-]+)|(\w+)|\.([\w\-]+))$/
    G = /[\x20\t\r\n\f]*[+~]/
    H = /:not\($/
    I = /h\d/i
    J = /input|select|textarea|button/i
    K = /\\(?!\\)/g
    L =
      ID: new RegExp("^#(" + s + ")")
      CLASS: new RegExp("^\\.(" + s + ")")
      NAME: new RegExp("^\\[name=['\"]?(" + s + ")['\"]?\\]")
      TAG: new RegExp("^(" + s.replace("[-", "[-\\*") + ")")
      ATTR: new RegExp("^" + v)
      PSEUDO: new RegExp("^" + w)
      CHILD: new RegExp("^:(only|nth|last|first)-child(?:\\(" + r + "*(even|odd|(([+-]|)(\\d*)n|)" + r + "*(?:([+-]|)" + r + "*(\\d+)|))" + r + "*\\)|)", "i")
      POS: new RegExp(x, "ig")
      needsContext: new RegExp("^" + r + "*[>+~]|" + x, "i")

    M = {}
    N = []
    O = {}
    P = []
    Q = (a) ->
      a.sizzleFilter = not 0
      a

    R = (a) ->
      (b) ->
        b.nodeName.toLowerCase() is "input" and b.type is a

    S = (a) ->
      (b) ->
        c = b.nodeName.toLowerCase()
        (c is "input" or c is "button") and b.type is a

    T = (a) ->
      b = not 1
      c = h.createElement("div")
      try
        b = a(c)
      c = null
      b

    U = T((a) ->
      a.innerHTML = "<select></select>"
      b = typeof a.lastChild.getAttribute("multiple")
      b isnt "boolean" and b isnt "string"
    )
    V = T((a) ->
      a.id = q + 0
      a.innerHTML = "<a name='" + q + "'></a><div name='" + q + "'></div>"
      i.insertBefore(a, i.firstChild)

      b = h.getElementsByName and h.getElementsByName(q).length is 2 + h.getElementsByName(q + 0).length
      g = not h.getElementById(q)
      i.removeChild(a)
      b
    )
    W = T((a) ->
      a.appendChild(h.createComment(""))
      a.getElementsByTagName("*").length is 0
    )
    X = T((a) ->
      a.innerHTML = "<a href='#'></a>"
      a.firstChild and typeof a.firstChild.getAttribute isnt j and a.firstChild.getAttribute("href") is "#"
    )
    Y = T((a) ->
      a.innerHTML = "<div class='hidden e'></div><div class='hidden'></div>"
      (if not a.getElementsByClassName or a.getElementsByClassName("e").length is 0 then not 1 else (a.lastChild.className = "e"
      a.getElementsByClassName("e").length isnt 1
      ))
    )
    Z = (a, b, c, d) ->
      c = c or []
      b = b or h

      e = undefined
      f = undefined
      g = undefined
      i = undefined
      j = b.nodeType
      return []  if j isnt 1 and j isnt 9
      return c  if not a or typeof a isnt "string"
      g = ba(b)
      if not g and not d
        if e = F.exec(a)
          if i = e[1]
            if j is 9
              f = b.getElementById(i)
              return c  if not f or not f.parentNode
              if f.id is i
                return c.push(f)
                c
            else if b.ownerDocument and (f = b.ownerDocument.getElementById(i)) and bb(b, f) and f.id is i
              return c.push(f)
              c
          else
            if e[2]
              return o.apply(c, n.call(b.getElementsByTagName(a), 0))
              c
            if (i = e[3]) and Y and b.getElementsByClassName
              return o.apply(c, n.call(b.getElementsByClassName(i), 0))
              c
      bm a, b, c, d, g

    $ = Z.selectors =
      cacheLength: 50
      match: L
      order: ["ID", "TAG"]
      attrHandle: {}
      createPseudo: Q
      find:
        ID: (if g then (a, b, c) ->
          if typeof b.getElementById isnt j and not c
            d = b.getElementById(a)
            (if d and d.parentNode then [d] else [])
         else (a, c, d) ->
          if typeof c.getElementById isnt j and not d
            e = c.getElementById(a)
            (if e then (if e.id is a or typeof e.getAttributeNode isnt j and e.getAttributeNode("id").value is a then [e] else b) else [])
        )
        TAG: (if W then (a, b) ->
          b.getElementsByTagName a  if typeof b.getElementsByTagName isnt j
         else (a, b) ->
          c = b.getElementsByTagName(a)
          if a is "*"
            d = undefined
            e = []
            f = 0
            while d = c[f]
              d.nodeType is 1 and e.push(d)
              f++
            return e
          c
        )

      relative:
        ">":
          dir: "parentNode"
          first: not 0

        " ":
          dir: "parentNode"

        "+":
          dir: "previousSibling"
          first: not 0

        "~":
          dir: "previousSibling"

      preFilter:
        ATTR: (a) ->
          a[1] = a[1].replace(K, "")
          a[3] = (a[4] or a[5] or "").replace(K, "")
          a[2] is "~=" and (a[3] = " " + a[3] + " ")
          a.slice(0, 4)

        CHILD: (a) ->
          a[1] = a[1].toLowerCase()
          (if a[1] is "nth" then (a[2] or Z.error(a[0])
          a[3] = +((if a[3] then a[4] + (a[5] or 1) else 2 * (a[2] is "even" or a[2] is "odd")))
          a[4] = +(a[6] + a[7] or a[2] is "odd")
          ) else a[2] and Z.error(a[0]))
          a

        PSEUDO: (a) ->
          b = undefined
          c = a[4]
          (if L.CHILD.test(a[0]) then null else (c and (b = D.exec(c)) and b.pop() and (a[0] = a[0].slice(0, b[0].length - c.length - 1)
          c = b[0].slice(0, -1)
          )
          a.splice(2, 3, c or a[3])
          a
          ))

      filter:
        ID: (if g then (a) ->
          a = a.replace(K, "")
          (b) ->
            b.getAttribute("id") is a
         else (a) ->
          a = a.replace(K, "")
          (b) ->
            c = typeof b.getAttributeNode isnt j and b.getAttributeNode("id")
            c and c.value is a
        )
        TAG: (a) ->
          (if a is "*" then ->
            not 0
           else (a = a.replace(K, "").toLowerCase()
          (b) ->
            b.nodeName and b.nodeName.toLowerCase() is a

          ))

        CLASS: (a) ->
          b = M[a]
          b or (b = M[a] = new RegExp("(^|" + r + ")" + a + "(" + r + "|$)")
          N.push(a)
          N.length > $.cacheLength and delete M[N.shift()]

          )
          (a) ->
            b.test a.className or typeof a.getAttribute isnt j and a.getAttribute("class") or ""

        ATTR: (a, b, c) ->
          (if b then (d) ->
            e = Z.attr(d, a)
            f = e + ""
            return b is "!="  unless e?
            switch b
              when "="
                f is c
              when "!="
                f isnt c
              when "^="
                c and f.indexOf(c) is 0
              when "*="
                c and f.indexOf(c) > -1
              when "$="
                c and f.substr(f.length - c.length) is c
              when "~="
                (" " + f + " ").indexOf(c) > -1
              when "|="
                f is c or f.substr(0, c.length + 1) is c + "-"
           else (b) ->
            Z.attr(b, a)?
          )

        CHILD: (a, b, c, d) ->
          if a is "nth"
            e = m++
            return (a) ->
              b = undefined
              f = undefined
              g = 0
              h = a
              return not 0  if c is 1 and d is 0
              b = a.parentNode
              if b and (b[q] isnt e or not a.sizset)
                h = b.firstChild
                while h
                  if h.nodeType is 1
                    h.sizset = ++g
                    break  if h is a
                  h = h.nextSibling
                b[q] = e
              f = a.sizset - d
              (if c is 0 then f is 0 else f % c is 0 and f / c >= 0)
          (b) ->
            c = b
            switch a
              when "only", "first"
                return not 1  if c.nodeType is 1  while c = c.previousSibling
                return not 0  if a is "first"
                c = b
              when "last"
                return not 1  if c.nodeType is 1  while c = c.nextSibling
                not 0

        PSEUDO: (a, b, c, d) ->
          e = $.pseudos[a] or $.pseudos[a.toLowerCase()]
          e or Z.error("unsupported pseudo: " + a)
          (if e.sizzleFilter then e(b, c, d) else e)

      pseudos:
        not: Q((a, b, c) ->
          d = bl(a.replace(A, "$1"), b, c)
          (a) ->
            not d(a)
        )
        enabled: (a) ->
          a.disabled is not 1

        disabled: (a) ->
          a.disabled is not 0

        checked: (a) ->
          b = a.nodeName.toLowerCase()
          b is "input" and !!a.checked or b is "option" and !!a.selected

        selected: (a) ->
          a.parentNode and a.parentNode.selectedIndex
          a.selected is not 0

        parent: (a) ->
          not $.pseudos.empty(a)

        empty: (a) ->
          b = undefined
          a = a.firstChild
          while a
            return not 1  if a.nodeName > "@" or (b = a.nodeType) is 3 or b is 4
            a = a.nextSibling
          not 0

        contains: Q((a) ->
          (b) ->
            (b.textContent or b.innerText or bc(b)).indexOf(a) > -1
        )
        has: Q((a) ->
          (b) ->
            Z(a, b).length > 0
        )
        header: (a) ->
          I.test a.nodeName

        text: (a) ->
          b = undefined
          c = undefined
          a.nodeName.toLowerCase() is "input" and (b = a.type) is "text" and (not (c = a.getAttribute("type"))? or c.toLowerCase() is b)

        radio: R("radio")
        checkbox: R("checkbox")
        file: R("file")
        password: R("password")
        image: R("image")
        submit: S("submit")
        reset: S("reset")
        button: (a) ->
          b = a.nodeName.toLowerCase()
          b is "input" and a.type is "button" or b is "button"

        input: (a) ->
          J.test a.nodeName

        focus: (a) ->
          b = a.ownerDocument
          a is b.activeElement and (not b.hasFocus or b.hasFocus()) and (!!a.type or !!a.href)

        active: (a) ->
          a is a.ownerDocument.activeElement

      setFilters:
        first: (a, b, c) ->
          (if c then a.slice(1) else [a[0]])

        last: (a, b, c) ->
          d = a.pop()
          (if c then a else [d])

        even: (a, b, c) ->
          d = []
          e = (if c then 1 else 0)
          f = a.length
          while e < f
            d.push a[e]
            e = e + 2
          d

        odd: (a, b, c) ->
          d = []
          e = (if c then 0 else 1)
          f = a.length
          while e < f
            d.push a[e]
            e = e + 2
          d

        lt: (a, b, c) ->
          (if c then a.slice(+b) else a.slice(0, +b))

        gt: (a, b, c) ->
          (if c then a.slice(0, +b + 1) else a.slice(+b + 1))

        eq: (a, b, c) ->
          d = a.splice(+b, 1)
          (if c then a else d)

    $.setFilters.nth = $.setFilters.eq
    $.filters = $.pseudos
    X or ($.attrHandle =
      href: (a) ->
        a.getAttribute "href", 2

      type: (a) ->
        a.getAttribute "type"
    )
    V and ($.order.push("NAME")
    $.find.NAME = (a, b) ->
      b.getElementsByName a  if typeof b.getElementsByName isnt j

    )
    Y and ($.order.splice(1, 0, "CLASS")
    $.find.CLASS = (a, b, c) ->
      b.getElementsByClassName a  if typeof b.getElementsByClassName isnt j and not c

    )

    try
      n.call(i.childNodes, 0)[0].nodeType
    catch _
      n = (a) ->
        b = undefined
        c = []
        while b = this[a]
          c.push b
          a++
        c
    ba = Z.isXML = (a) ->
      b = a and (a.ownerDocument or a).documentElement
      (if b then b.nodeName isnt "HTML" else not 1)

    bb = Z.contains = (if i.compareDocumentPosition then (a, b) ->
      !!(a.compareDocumentPosition(b) & 16)
     else (if i.contains then (a, b) ->
      c = (if a.nodeType is 9 then a.documentElement else a)
      d = b.parentNode
      a is d or !!(d and d.nodeType is 1 and c.contains and c.contains(d))
     else (a, b) ->
      return not 0  if b is a  while b = b.parentNode
      not 1
    ))
    bc = Z.getText = (a) ->
      b = undefined
      c = ""
      d = 0
      e = a.nodeType
      if e
        if e is 1 or e is 9 or e is 11
          return a.textContent  if typeof a.textContent is "string"
          a = a.firstChild
          while a
            c += bc(a)
            a = a.nextSibling
        else return a.nodeValue  if e is 3 or e is 4
      else
        while b = a[d]
          c += bc(b)
          d++
      c

    Z.attr = (a, b) ->
      c = undefined
      d = ba(a)
      d or (b = b.toLowerCase())
      (if $.attrHandle[b] then $.attrHandle[b](a) else (if U or d then a.getAttribute(b) else (c = a.getAttributeNode(b)
      (if c then (if typeof a[b] is "boolean" then (if a[b] then b else null) else (if c.specified then c.value else null)) else null)
      )))

    Z.error = (a) ->
      throw new Error("Syntax error, unrecognized expression: " + a)

    [0, 0].sort(->
      l = 0
    )
    (if i.compareDocumentPosition then e = (a, b) ->
      (if a is b then (k = not 0
      0
      ) else (if ((if not a.compareDocumentPosition or not b.compareDocumentPosition then a.compareDocumentPosition else a.compareDocumentPosition(b) & 4)) then -1 else 1))
     else (e = (a, b) ->
      if a is b
        return k = not 0
        0
      return a.sourceIndex - b.sourceIndex  if a.sourceIndex and b.sourceIndex
      c = undefined
      d = undefined
      e = []
      g = []
      h = a.parentNode
      i = b.parentNode
      j = h
      return f(a, b)  if h is i
      return -1  unless h
      return 1  unless i
      while j
        e.unshift(j)
        j = j.parentNode
      j = i
      while j
        g.unshift(j)
        j = j.parentNode
      c = e.length
      d = g.length

      l = 0

      while l < c and l < d
        return f(e[l], g[l])  if e[l] isnt g[l]
        l++
      (if l is c then f(a, g[l], -1) else f(e[l], b, 1))

    f = (a, b, c) ->
      return c  if a is b
      d = a.nextSibling
      while d
        return -1  if d is b
        d = d.nextSibling
      1

    ))
    Z.uniqueSort = (a) ->
      b = undefined
      c = 1
      if e
        k = l
        a.sort(e)

        if k
          while b = a[c]
            b is a[c - 1] and a.splice(c--, 1)
            c++
      a


    bl = Z.compile = (a, b, c) ->
      d = undefined
      e = undefined
      f = undefined
      g = O[a]
      return g  if g and g.context is b
      e = bg(a, b, c)
      f = 0
      while d = e[f]
        e[f] = bj(d, b, c)
        f++
      g = O[a] = bk(e)
      g.context = b
      g.runs = g.dirruns = 0
      P.push(a)
      P.length > $.cacheLength and delete O[P.shift()]

      g

    Z.matches = (a, b) ->
      Z a, null, null, b

    Z.matchesSelector = (a, b) ->
      Z(b, null, null, [a]).length > 0


    bm = (a, b, e, f, g) ->
      a = a.replace(A, "$1")
      h = undefined
      i = undefined
      j = undefined
      k = undefined
      l = undefined
      m = undefined
      p = undefined
      q = undefined
      r = undefined
      s = a.match(C)
      t = a.match(E)
      u = b.nodeType
      return bf(a, b, e, f, s)  if L.POS.test(a)
      if f
        h = n.call(f, 0)
      else if s and s.length is 1
        if t.length > 1 and u is 9 and not g and (s = L.ID.exec(t[0]))
          b = $.find.ID(s[1], b, g)[0]
          return e  unless b
          a = a.slice(t.shift().length)
        q = (s = G.exec(t[0])) and not s.index and b.parentNode or b
        r = t.pop()
        m = r.split(":not")[0]

        j = 0
        k = $.order.length

        while j < k
          p = $.order[j]
          if s = L[p].exec(m)
            h = $.find[p]((s[1] or "").replace(K, ""), q, g)
            continue  unless h?
            m is r and (a = a.slice(0, a.length - r.length) + m.replace(L[p], "")
            a or o.apply(e, n.call(h, 0))
            )
            break
          j++
      if a
        i = bl(a, b, g)
        d = i.dirruns++
        not h? and (h = $.find.TAG("*", G.test(a) and b.parentNode or b))

        j = 0
        while l = h[j]
          c = i.runs++
          i(l, b) and e.push(l)
          j++
      e

    h.querySelectorAll and ->
      a = undefined
      b = bm
      c = /'|\\/g
      d = /\=[\x20\t\r\n\f]*([^'"\]]*)[\x20\t\r\n\f]*\]/g
      e = []
      f = [":active"]
      g = i.matchesSelector or i.mozMatchesSelector or i.webkitMatchesSelector or i.oMatchesSelector or i.msMatchesSelector
      T((a) ->
        a.innerHTML = "<select><option selected></option></select>"
        a.querySelectorAll("[selected]").length or e.push("\\[" + r + "*(?:checked|disabled|ismap|multiple|readonly|selected|value)")
        a.querySelectorAll(":checked").length or e.push(":checked")
      )
      T((a) ->
        a.innerHTML = "<p test=''></p>"
        a.querySelectorAll("[test^='']").length and e.push("[*^$]=" + r + "*(?:\"\"|'')")
        a.innerHTML = "<input type='hidden'>"
        a.querySelectorAll(":enabled").length or e.push(":enabled", ":disabled")
      )
      e = e.length and new RegExp(e.join("|"))
      bm = (a, d, f, g, h) ->
        if not g and not h and (not e or not e.test(a))
          if d.nodeType is 9
            try
              return o.apply(f, n.call(d.querySelectorAll(a), 0))
              f
          else if d.nodeType is 1 and d.nodeName.toLowerCase() isnt "object"
            j = d.getAttribute("id")
            k = j or q
            l = G.test(a) and d.parentNode or d
            (if j then k = k.replace(c, "\\$&") else d.setAttribute("id", k))
            try
              return o.apply(f, n.call(l.querySelectorAll(a.replace(C, "[id='" + k + "'] $&")), 0))
              f
            finally
              j or d.removeAttribute("id")
        b a, d, f, g, h

      g and (T((b) ->
        a = g.call(b, "div")
        try
          g.call(b, "[test!='']:sizzle")
          f.push($.match.PSEUDO)
      )
      f = new RegExp(f.join("|"))
      Z.matchesSelector = (b, c) ->
        c = c.replace(d, "='$1']")
        if not ba(b) and not f.test(c) and (not e or not e.test(c))
          try
            h = g.call(b, c)
            return h  if h or a or b.document and b.document.nodeType isnt 11
        Z(c, null, null, [b]).length > 0

      )
    ()
    Z.attr = p.attr
    p.find = Z
    p.expr = Z.selectors
    p.expr[":"] = p.expr.pseudos
    p.unique = Z.uniqueSort
    p.text = Z.getText
    p.isXMLDoc = Z.isXML
    p.contains = Z.contains
  (a)

  bc = /Until$/
  bd = /^(?:parents|prev(?:Until|All))/
  be = /^.[^:#\[\.,]*$/
  bf = p.expr.match.needsContext
  bg =
    children: not 0
    contents: not 0
    next: not 0
    prev: not 0

  p.fn.extend(
    find: (a) ->
      b = undefined
      c = undefined
      d = undefined
      e = undefined
      f = undefined
      g = undefined
      h = this
      unless typeof a is "string"
        return p(a).filter(->
          b = 0
          c = h.length

          while b < c
            return not 0  if p.contains(h[b], this)
            b++
        )
      g = @pushStack("", "find", a)
      b = 0
      c = @length

      while b < c
        d = g.length
        p.find(a, this[b], g)

        if b > 0
          e = d
          while e < g.length
            f = 0
            while f < d
              if g[f] is g[e]
                g.splice e--, 1
                break
              f++
            e++
        b++
      g

    has: (a) ->
      b = undefined
      c = p(a, this)
      d = c.length
      @filter ->
        b = 0
        while b < d
          return not 0  if p.contains(this, c[b])
          b++


    not: (a) ->
      @pushStack bj(this, a, not 1), "not", a

    filter: (a) ->
      @pushStack bj(this, a, not 0), "filter", a

    is: (a) ->
      !!a and ((if typeof a is "string" then (if bf.test(a) then p(a, @context).index(this[0]) >= 0 else p.filter(a, this).length > 0) else @filter(a).length > 0))

    closest: (a, b) ->
      c = undefined
      d = 0
      e = @length
      f = []
      g = (if bf.test(a) or typeof a isnt "string" then p(a, b or @context) else 0)
      while d < e
        c = this[d]
        while c and c.ownerDocument and c isnt b and c.nodeType isnt 11
          if (if g then g.index(c) > -1 else p.find.matchesSelector(c, a))
            f.push c
            break
          c = c.parentNode
        d++
      f = (if f.length > 1 then p.unique(f) else f)
      @pushStack(f, "closest", a)

    index: (a) ->
      (if a then (if typeof a is "string" then p.inArray(this[0], p(a)) else p.inArray((if a.jquery then a[0] else a), this)) else (if this[0] and this[0].parentNode then @prevAll().length else -1))

    add: (a, b) ->
      c = (if typeof a is "string" then p(a, b) else p.makeArray((if a and a.nodeType then [a] else a)))
      d = p.merge(@get(), c)
      @pushStack (if bh(c[0]) or bh(d[0]) then d else p.unique(d))

    addBack: (a) ->
      @add (if not a? then @prevObject else @prevObject.filter(a))
  )
  p.fn.andSelf = p.fn.addBack
  p.each(
    parent: (a) ->
      b = a.parentNode
      (if b and b.nodeType isnt 11 then b else null)

    parents: (a) ->
      p.dir a, "parentNode"

    parentsUntil: (a, b, c) ->
      p.dir a, "parentNode", c

    next: (a) ->
      bi a, "nextSibling"

    prev: (a) ->
      bi a, "previousSibling"

    nextAll: (a) ->
      p.dir a, "nextSibling"

    prevAll: (a) ->
      p.dir a, "previousSibling"

    nextUntil: (a, b, c) ->
      p.dir a, "nextSibling", c

    prevUntil: (a, b, c) ->
      p.dir a, "previousSibling", c

    siblings: (a) ->
      p.sibling (a.parentNode or {}).firstChild, a

    children: (a) ->
      p.sibling a.firstChild

    contents: (a) ->
      (if p.nodeName(a, "iframe") then a.contentDocument or a.contentWindow.document else p.merge([], a.childNodes))
  , (a, b) ->
    p.fn[a] = (c, d) ->
      e = p.map(this, b, c)
      bc.test(a) or (d = c)
      d and typeof d is "string" and (e = p.filter(d, e))
      e = (if @length > 1 and not bg[a] then p.unique(e) else e)
      @length > 1 and bd.test(a) and (e = e.reverse())
      @pushStack(e, a, k.call(arguments_).join(","))
  )
  p.extend(
    filter: (a, b, c) ->
      c and (a = ":not(" + a + ")")
      (if b.length is 1 then (if p.find.matchesSelector(b[0], a) then [b[0]] else []) else p.find.matches(a, b))

    dir: (a, c, d) ->
      e = []
      f = a[c]
      while f and f.nodeType isnt 9 and (d is b or f.nodeType isnt 1 or not p(f).is(d))
        f.nodeType is 1 and e.push(f)
        f = f[c]
      e

    sibling: (a, b) ->
      c = []
      while a
        a.nodeType is 1 and a isnt b and c.push(a)
        a = a.nextSibling
      c
  )

  bl = "abbr|article|aside|audio|bdi|canvas|data|datalist|details|figcaption|figure|footer|header|hgroup|mark|meter|nav|output|progress|section|summary|time|video"
  bm = RegExp(" jQuery\\d+=\"(?:null|\\d+)\"", "g")
  bn = /^\s+/
  bo = /<(?!area|br|col|embed|hr|img|input|link|meta|param)(([\w:]+)[^>]*)\/>/g
  bp = /<([\w:]+)/
  bq = /<tbody/i
  br = /<|&#?\w+;/
  bs = /<(?:script|style|link)/i
  bt = /<(?:script|object|embed|option|style)/i
  bu = new RegExp("<(?:" + bl + ")[\\s/>]", "i")
  bv = /^(?:checkbox|radio)$/
  bw = /checked\s*(?:[^=]|=\s*.checked.)/i
  bx = /\/(java|ecma)script/i
  by_ = /^\s*<!(?:\[CDATA\[|\-\-)|[\]\-]{2}>\s*$/g
  bz =
    option: [1, "<select multiple='multiple'>", "</select>"]
    legend: [1, "<fieldset>", "</fieldset>"]
    thead: [1, "<table>", "</table>"]
    tr: [2, "<table><tbody>", "</tbody></table>"]
    td: [3, "<table><tbody><tr>", "</tr></tbody></table>"]
    col: [2, "<table><tbody></tbody><colgroup>", "</colgroup></table>"]
    area: [1, "<map>", "</map>"]
    _default: [0, "", ""]

  bA = bk(e)
  bB = bA.appendChild(e.createElement("div"))
  bz.optgroup = bz.option
  bz.tbody = bz.tfoot = bz.colgroup = bz.caption = bz.thead
  bz.th = bz.td
  p.support.htmlSerialize or (bz._default = [1, "X<div>", "</div>"])
  p.fn.extend(
    text: (a) ->
      p.access this, ((a) ->
        (if a is b then p.text(this) else @empty().append((this[0] and this[0].ownerDocument or e).createTextNode(a)))
      ), null, a, arguments_.length

    wrapAll: (a) ->
      if p.isFunction(a)
        return @each((b) ->
          p(this).wrapAll a.call(this, b)
        )
      if this[0]
        b = p(a, this[0].ownerDocument).eq(0).clone(not 0)
        this[0].parentNode and b.insertBefore(this[0])
        b.map(->
          a = this
          a = a.firstChild  while a.firstChild and a.firstChild.nodeType is 1
          a
        ).append(this)
      this

    wrapInner: (a) ->
      (if p.isFunction(a) then @each((b) ->
        p(this).wrapInner a.call(this, b)
      ) else @each(->
        b = p(this)
        c = b.contents()
        (if c.length then c.wrapAll(a) else b.append(a))
      ))

    wrap: (a) ->
      b = p.isFunction(a)
      @each (c) ->
        p(this).wrapAll (if b then a.call(this, c) else a)


    unwrap: ->
      @parent().each(->
        p.nodeName(this, "body") or p(this).replaceWith(@childNodes)
      ).end()

    append: ->
      @domManip arguments_, not 0, (a) ->
        (@nodeType is 1 or @nodeType is 11) and @appendChild(a)


    prepend: ->
      @domManip arguments_, not 0, (a) ->
        (@nodeType is 1 or @nodeType is 11) and @insertBefore(a, @firstChild)


    before: ->
      unless bh(this[0])
        return @domManip(arguments_, not 1, (a) ->
          @parentNode.insertBefore a, this
        )
      if arguments_.length
        a = p.clean(arguments_)
        @pushStack p.merge(a, this), "before", @selector

    after: ->
      unless bh(this[0])
        return @domManip(arguments_, not 1, (a) ->
          @parentNode.insertBefore a, @nextSibling
        )
      if arguments_.length
        a = p.clean(arguments_)
        @pushStack p.merge(this, a), "after", @selector

    remove: (a, b) ->
      c = undefined
      d = 0
      while (c = this[d])?
        if not a or p.filter(a, [c]).length
          not b and c.nodeType is 1 and (p.cleanData(c.getElementsByTagName("*"))
          p.cleanData([c])
          )
          c.parentNode and c.parentNode.removeChild(c)
        d++
      this

    empty: ->
      a = undefined
      b = 0
      while (a = this[b])?
        a.nodeType is 1 and p.cleanData(a.getElementsByTagName("*"))
        a.removeChild a.firstChild  while a.firstChild
        b++
      this

    clone: (a, b) ->
      a = (if not a? then not 1 else a)
      b = (if not b? then a else b)
      @map(->
        p.clone this, a, b
      )

    html: (a) ->
      p.access this, ((a) ->
        c = this[0] or {}
        d = 0
        e = @length
        return (if c.nodeType is 1 then c.innerHTML.replace(bm, "") else b)  if a is b
        if typeof a is "string" and not bs.test(a) and (p.support.htmlSerialize or not bu.test(a)) and (p.support.leadingWhitespace or not bn.test(a)) and not bz[(bp.exec(a) or ["", ""])[1].toLowerCase()]
          a = a.replace(bo, "<$1></$2>")
          try
            while d < e
              c = this[d] or {}
              c.nodeType is 1 and (p.cleanData(c.getElementsByTagName("*"))
              c.innerHTML = a
              )
              d++
            c = 0
        c and @empty().append(a)
      ), null, a, arguments_.length

    replaceWith: (a) ->
      (if bh(this[0]) then (if @length then @pushStack(p((if p.isFunction(a) then a() else a)), "replaceWith", a) else this) else (if p.isFunction(a) then @each((b) ->
        c = p(this)
        d = c.html()
        c.replaceWith a.call(this, b, d)
      ) else (typeof a isnt "string" and (a = p(a).detach())
      @each(->
        b = @nextSibling
        c = @parentNode
        p(this).remove()
        (if b then p(b).before(a) else p(c).append(a))
      )
      )))

    detach: (a) ->
      @remove a, not 0

    domManip: (a, c, d) ->
      a = [].concat.apply([], a)
      e = undefined
      f = undefined
      g = undefined
      h = undefined
      i = 0
      j = a[0]
      k = []
      l = @length
      if not p.support.checkClone and l > 1 and typeof j is "string" and bw.test(j)
        return @each(->
          p(this).domManip a, c, d
        )
      if p.isFunction(j)
        return @each((e) ->
          f = p(this)
          a[0] = j.call(this, e, (if c then f.html() else b))
          f.domManip(a, c, d)
        )
      if this[0]
        e = p.buildFragment(a, this, k)
        g = e.fragment
        f = g.firstChild
        g.childNodes.length is 1 and (g = f)

        if f
          c = c and p.nodeName(f, "tr")
          h = e.cacheable or l - 1
          while i < l
            d.call (if c and p.nodeName(this[i], "table") then bC(this[i], "tbody") else this[i]), (if i is h then g else p.clone(g, not 0, not 0))
            i++
        g = f = null
        k.length and p.each(k, (a, b) ->
          (if b.src then (if p.ajax then p.ajax(
            url: b.src
            type: "GET"
            dataType: "script"
            async: not 1
            global: not 1
            throws: not 0
          ) else p.error("no ajax")) else p.globalEval((b.text or b.textContent or b.innerHTML or "").replace(by_, "")))
          b.parentNode and b.parentNode.removeChild(b)
        )
      this
  )
  p.buildFragment = (a, c, d) ->
    f = undefined
    g = undefined
    h = undefined
    i = a[0]
    c = c or e
    c = (c[0] or c).ownerDocument or c[0] or c
    typeof c.createDocumentFragment is "undefined" and (c = e)
    a.length is 1 and typeof i is "string" and i.length < 512 and c is e and i.charAt(0) is "<" and not bt.test(i) and (p.support.checkClone or not bw.test(i)) and (p.support.html5Clone or not bu.test(i)) and (g = not 0
    f = p.fragments[i]
    h = f isnt b
    )
    f or (f = c.createDocumentFragment()
    p.clean(a, c, f, d)
    g and (p.fragments[i] = h and f)
    )

      fragment: f
      cacheable: g

  p.fragments = {}
  p.each(
    appendTo: "append"
    prependTo: "prepend"
    insertBefore: "before"
    insertAfter: "after"
    replaceAll: "replaceWith"
  , (a, b) ->
    p.fn[a] = (c) ->
      d = undefined
      e = 0
      f = []
      g = p(c)
      h = g.length
      i = @length is 1 and this[0].parentNode
      if (not i? or i and i.nodeType is 11 and i.childNodes.length is 1) and h is 1
        return g[b](this[0])
        this
      while e < h
        d = ((if e > 0 then @clone(not 0) else this)).get()
        p(g[e])[b](d)
        f = f.concat(d)
        e++
      @pushStack f, a, g.selector
  )
  p.extend(
    clone: (a, b, c) ->
      d = undefined
      e = undefined
      f = undefined
      g = undefined
      (if p.support.html5Clone or p.isXMLDoc(a) or not bu.test("<" + a.nodeName + ">") then g = a.cloneNode(not 0) else (bB.innerHTML = a.outerHTML
      bB.removeChild(g = bB.firstChild)
      ))
      if (not p.support.noCloneEvent or not p.support.noCloneChecked) and (a.nodeType is 1 or a.nodeType is 11) and not p.isXMLDoc(a)
        bE(a, g)
        d = bF(a)
        e = bF(g)

        f = 0
        while d[f]
          e[f] and bE(d[f], e[f])
          ++f
      if b
        bD a, g
        if c
          d = bF(a)
          e = bF(g)

          f = 0
          while d[f]
            bD d[f], e[f]
            ++f
      d = e = null
      g

    clean: (a, b, c, d) ->
      f = undefined
      g = undefined
      h = undefined
      i = undefined
      j = undefined
      k = undefined
      l = undefined
      m = undefined
      n = undefined
      o = undefined
      q = undefined
      r = undefined
      s = 0
      t = []
      b = e  if not b or typeof b.createDocumentFragment is "undefined"
      g = b is e and bA
      while (h = a[s])?
        typeof h is "number" and (h += "")
        continue  unless h
        if typeof h is "string"
          if br.test(h)
            g = g or bk(b)
            l = l or g.appendChild(b.createElement("div"))
            h = h.replace(bo, "<$1></$2>")
            i = (bp.exec(h) or ["", ""])[1].toLowerCase()
            j = bz[i] or bz._default
            k = j[0]
            l.innerHTML = j[1] + h + j[2]

            l = l.lastChild  while k--
            unless p.support.tbody
              m = bq.test(h)
              n = (if i is "table" and not m then l.firstChild and l.firstChild.childNodes else (if j[1] is "<table>" and not m then l.childNodes else []))

              f = n.length - 1
              while f >= 0
                p.nodeName(n[f], "tbody") and not n[f].childNodes.length and n[f].parentNode.removeChild(n[f])
                --f
            not p.support.leadingWhitespace and bn.test(h) and l.insertBefore(b.createTextNode(bn.exec(h)[0]), l.firstChild)
            h = l.childNodes
            l = g.lastChild
        (if h.nodeType then t.push(h) else t = p.merge(t, h))
        s++
      l and (g.removeChild(l)
      h = l = g = null
      )
      unless p.support.appendChecked
        s = 0
        while (h = t[s])?
          (if p.nodeName(h, "input") then bG(h) else typeof h.getElementsByTagName isnt "undefined" and p.grep(h.getElementsByTagName("input"), bG))
          s++
      if c
        q = (a) ->
          (if d then d.push((if a.parentNode then a.parentNode.removeChild(a) else a)) else c.appendChild(a))  if not a.type or bx.test(a.type)

        s = 0
        while (h = t[s])?
          if not p.nodeName(h, "script") or not q(h)
            c.appendChild(h)
            typeof h.getElementsByTagName isnt "undefined" and (r = p.grep(p.merge([], h.getElementsByTagName("script")), q)
            t.splice.apply(t, [s + 1, 0].concat(r))
            s += r.length
            )
          s++
      t

    cleanData: (a, b) ->
      c = undefined
      d = undefined
      e = undefined
      f = undefined
      g = 0
      h = p.expando
      i = p.cache
      j = p.support.deleteExpando
      k = p.event.special
      while (e = a[g])?
        if b or p.acceptData(e)
          d = e[h]
          c = d and i[d]

          if c
            if c.events
              for f of c.events
                (if k[f] then p.event.remove(e, f) else p.removeEvent(e, f, c.handle))
            i[d] and (delete i[d]

            (if j then delete e[h]
             else (if e.removeAttribute then e.removeAttribute(h) else e[h] = null))
            p.deletedIds.push(d)
            )
        g++
  )
  ->
    a = undefined
    b = undefined
    p.uaMatch = (a) ->
      a = a.toLowerCase()
      b = /(chrome)[ \/]([\w.]+)/.exec(a) or /(webkit)[ \/]([\w.]+)/.exec(a) or /(opera)(?:.*version|)[ \/]([\w.]+)/.exec(a) or /(msie) ([\w.]+)/.exec(a) or a.indexOf("compatible") < 0 and /(mozilla)(?:.*? rv:([\w.]+)|)/.exec(a) or []
      browser: b[1] or ""
      version: b[2] or "0"

    a = p.uaMatch(g.userAgent)
    b = {}
    a.browser and (b[a.browser] = not 0
    b.version = a.version
    )
    b.webkit and (b.safari = not 0)
    p.browser = b
    p.sub = ->
      a = (b, c) ->
        new a.fn.init(b, c)
      p.extend(not 0, a, this)
      a.superclass = this
      a.fn = a:: = this()
      a.fn.constructor = a
      a.sub = @sub
      a.fn.init = c = (c, d) ->
        d and d instanceof p and (d not instanceof a) and (d = a(d))
        p.fn.init.call(this, c, d, b)

      a.fn.init:: = a.fn

      b = a(e)
      a
  ()

  bH = undefined
  bI = undefined
  bJ = undefined
  bK = /alpha\([^)]*\)/i
  bL = /opacity=([^)]*)/
  bM = /^(top|right|bottom|left)$/
  bN = /^margin/
  bO = new RegExp("^(" + q + ")(.*)$", "i")
  bP = new RegExp("^(" + q + ")(?!px)[a-z%]+$", "i")
  bQ = new RegExp("^([-+])=(" + q + ")", "i")
  bR = {}
  bS =
    position: "absolute"
    visibility: "hidden"
    display: "block"

  bT =
    letterSpacing: 0
    fontWeight: 400
    lineHeight: 1

  bU = ["Top", "Right", "Bottom", "Left"]
  bV = ["Webkit", "O", "Moz", "ms"]
  bW = p.fn.toggle
  p.fn.extend(
    css: (a, c) ->
      p.access this, ((a, c, d) ->
        (if d isnt b then p.style(a, c, d) else p.css(a, c))
      ), a, c, arguments_.length > 1

    show: ->
      bZ this, not 0

    hide: ->
      bZ this

    toggle: (a, b) ->
      c = typeof a is "boolean"
      (if p.isFunction(a) and p.isFunction(b) then bW.apply(this, arguments_) else @each(->
        (if ((if c then a else bY(this))) then p(this).show() else p(this).hide())
      ))
  )
  p.extend(
    cssHooks:
      opacity:
        get: (a, b) ->
          if b
            c = bH(a, "opacity")
            (if c is "" then "1" else c)

    cssNumber:
      fillOpacity: not 0
      fontWeight: not 0
      lineHeight: not 0
      opacity: not 0
      orphans: not 0
      widows: not 0
      zIndex: not 0
      zoom: not 0

    cssProps:
      float: (if p.support.cssFloat then "cssFloat" else "styleFloat")

    style: (a, c, d, e) ->
      return  if not a or a.nodeType is 3 or a.nodeType is 8 or not a.style
      f = undefined
      g = undefined
      h = undefined
      i = p.camelCase(c)
      j = a.style
      c = p.cssProps[i] or (p.cssProps[i] = bX(j, i))
      h = p.cssHooks[c] or p.cssHooks[i]

      return (if h and "get" of h and (f = h.get(a, not 1, e)) isnt b then f else j[c])  if d is b
      g = typeof d
      g is "string" and (f = bQ.exec(d)) and (d = (f[1] + 1) * f[2] + parseFloat(p.css(a, c))
      g = "number"
      )

      return  if not d? or g is "number" and isNaN(d)
      g is "number" and not p.cssNumber[i] and (d += "px")
      if not h or ("set" not of h) or (d = h.set(a, d, e)) isnt b
        try
          j[c] = d

    css: (a, c, d, e) ->
      f = undefined
      g = undefined
      h = undefined
      i = p.camelCase(c)
      c = p.cssProps[i] or (p.cssProps[i] = bX(a.style, i))
      h = p.cssHooks[c] or p.cssHooks[i]
      h and "get" of h and (f = h.get(a, not 0, e))
      f is b and (f = bH(a, c))
      f is "normal" and c of bT and (f = bT[c])
      (if d or e isnt b then (g = parseFloat(f)
      (if d or p.isNumeric(g) then g or 0 else f)
      ) else f)

    swap: (a, b, c) ->
      d = undefined
      e = undefined
      f = {}
      for e of b
        f[e] = a.style[e]
        a.style[e] = b[e]
      d = c.call(a)
      for e of b
        a.style[e] = f[e]
      d
  )
  (if a.getComputedStyle then bH = (a, b) ->
    c = undefined
    d = undefined
    e = undefined
    f = undefined
    g = getComputedStyle(a, null)
    h = a.style
    g and (c = g[b]
    c is "" and not p.contains(a.ownerDocument.documentElement, a) and (c = p.style(a, b))
    bP.test(c) and bN.test(b) and (d = h.width
    e = h.minWidth
    f = h.maxWidth
    h.minWidth = h.maxWidth = h.width = c
    c = g.width
    h.width = d
    h.minWidth = e
    h.maxWidth = f
    )
    )
    c
   else e.documentElement.currentStyle and (bH = (a, b) ->
    c = undefined
    d = undefined
    e = a.currentStyle and a.currentStyle[b]
    f = a.style
    not e? and f and f[b] and (e = f[b])
    bP.test(e) and not bM.test(b) and (c = f.left
    d = a.runtimeStyle and a.runtimeStyle.left
    d and (a.runtimeStyle.left = a.currentStyle.left)
    f.left = (if b is "fontSize" then "1em" else e)
    e = f.pixelLeft + "px"
    f.left = c
    d and (a.runtimeStyle.left = d)
    )
    (if e is "" then "auto" else e)
  ))
  p.each(["height", "width"], (a, b) ->
    p.cssHooks[b] =
      get: (a, c, d) ->
        if c
          (if a.offsetWidth isnt 0 or bH(a, "display") isnt "none" then ca(a, b, d) else p.swap(a, bS, ->
            ca a, b, d
          ))

      set: (a, c, d) ->
        b$ a, c, (if d then b_(a, b, d, p.support.boxSizing and p.css(a, "boxSizing") is "border-box") else 0)
  )
  p.support.opacity or (p.cssHooks.opacity =
    get: (a, b) ->
      (if bL.test(((if b and a.currentStyle then a.currentStyle.filter else a.style.filter)) or "") then .01 * parseFloat(RegExp.$1) + "" else (if b then "1" else ""))

    set: (a, b) ->
      c = a.style
      d = a.currentStyle
      e = (if p.isNumeric(b) then "alpha(opacity=" + b * 100 + ")" else "")
      f = d and d.filter or c.filter or ""
      c.zoom = 1
      if b >= 1 and p.trim(f.replace(bK, "")) is "" and c.removeAttribute
        c.removeAttribute "filter"
        return  if d and not d.filter
      c.filter = (if bK.test(f) then f.replace(bK, e) else f + " " + e)
  )
  p(->
    p.support.reliableMarginRight or (p.cssHooks.marginRight = get: (a, b) ->
      p.swap a,
        display: "inline-block"
      , ->
        bH a, "marginRight"  if b

    )
    not p.support.pixelPosition and p.fn.position and p.each(["top", "left"], (a, b) ->
      p.cssHooks[b] = get: (a, c) ->
        if c
          d = bH(a, b)
          (if bP.test(d) then p(a).position()[b] + "px" else d)
    )
  )
  p.expr and p.expr.filters and (p.expr.filters.hidden = (a) ->
    a.offsetWidth is 0 and a.offsetHeight is 0 or not p.support.reliableHiddenOffsets and (a.style and a.style.display or bH(a, "display")) is "none"

  p.expr.filters.visible = (a) ->
    not p.expr.filters.hidden(a)

  )
  p.each(
    margin: ""
    padding: ""
    border: "Width"
  , (a, b) ->
    p.cssHooks[a + b] = expand: (c) ->
      d = undefined
      e = (if typeof c is "string" then c.split(" ") else [c])
      f = {}
      d = 0
      while d < 4
        f[a + bU[d] + b] = e[d] or e[d - 2] or e[0]
        d++
      f

    bN.test(a) or (p.cssHooks[a + b].set = b$)
  )

  cc = /%20/g
  cd = /\[\]$/
  ce = /\r?\n/g
  cf = /^(?:color|date|datetime|datetime-local|email|hidden|month|number|password|range|search|tel|text|time|url|week)$/i
  cg = /^(?:select|textarea)/i
  p.fn.extend(
    serialize: ->
      p.param @serializeArray()

    serializeArray: ->
      @map(->
        (if @elements then p.makeArray(@elements) else this)
      ).filter(->
        @name and not @disabled and (@checked or cg.test(@nodeName) or cf.test(@type))
      ).map((a, b) ->
        c = p(this).val()
        (if not c? then null else (if p.isArray(c) then p.map(c, (a, c) ->
          name: b.name
          value: a.replace(ce, "\r\n")
        ) else
          name: b.name
          value: c.replace(ce, "\r\n")
        ))
      ).get()
  )
  p.param = (a, c) ->
    d = undefined
    e = []
    f = (a, b) ->
      b = (if p.isFunction(b) then b() else (if not b? then "" else b))
      e[e.length] = encodeURIComponent(a) + "=" + encodeURIComponent(b)

    c is b and (c = p.ajaxSettings and p.ajaxSettings.traditional)
    if p.isArray(a) or a.jquery and not p.isPlainObject(a)
      p.each a, ->
        f @name, @value

    else
      for d of a
        ch d, a[d], c, f
    e.join("&").replace cc, "+"


  ci = undefined
  cj = undefined
  ck = /#.*$/
  cl = /^(.*?):[ \t]*([^\r\n]*)\r?$/g
  cm = /^(?:about|app|app\-storage|.+\-extension|file|res|widget):$/
  cn = /^(?:GET|HEAD)$/
  co = /^\/\//
  cp = /\?/
  cq = /<script\b[^<]*(?:(?!<\/script>)<[^<]*)*<\/script>/g
  cr = /([?&])_=[^&]*/
  cs = /^([\w\+\.\-]+:)(?:\/\/([^\/?#:]*)(?::(\d+)|)|)/
  ct = p.fn.load
  cu = {}
  cv = {}
  cw = ["*/"] + ["*"]
  try
    ci = f.href
  catch cx
    ci = e.createElement("a")
    ci.href = ""
    ci = ci.href
  cj = cs.exec(ci.toLowerCase()) or []
  p.fn.load = (a, c, d) ->
    return ct.apply(this, arguments_)  if typeof a isnt "string" and ct
    return this  unless @length
    e = undefined
    f = undefined
    g = undefined
    h = this
    i = a.indexOf(" ")
    i >= 0 and (e = a.slice(i, a.length)
    a = a.slice(0, i)
    )
    (if p.isFunction(c) then (d = c
    c = b
    ) else typeof c is "object" and (f = "POST"))
    p.ajax(
      url: a
      type: f
      dataType: "html"
      data: c
      complete: (a, b) ->
        d and h.each(d, g or [a.responseText, b, a])
    ).done((a) ->
      g = arguments_
      h.html((if e then p("<div>").append(a.replace(cq, "")).find(e) else a))
    )
    this

  p.each("ajaxStart ajaxStop ajaxComplete ajaxError ajaxSuccess ajaxSend".split(" "), (a, b) ->
    p.fn[b] = (a) ->
      @on b, a
  )
  p.each(["get", "post"], (a, c) ->
    p[c] = (a, d, e, f) ->
      p.isFunction(d) and (f = f or e
      e = d
      d = b
      )
      p.ajax(
        type: c
        url: a
        data: d
        success: e
        dataType: f
      )
  )
  p.extend(
    getScript: (a, c) ->
      p.get a, b, c, "script"

    getJSON: (a, b, c) ->
      p.get a, b, c, "json"

    ajaxSetup: (a, b) ->
      (if b then cA(a, p.ajaxSettings) else (b = a
      a = p.ajaxSettings
      ))
      cA(a, b)
      a

    ajaxSettings:
      url: ci
      isLocal: cm.test(cj[1])
      global: not 0
      type: "GET"
      contentType: "application/x-www-form-urlencoded; charset=UTF-8"
      processData: not 0
      async: not 0
      accepts:
        xml: "application/xml, text/xml"
        html: "text/html"
        text: "text/plain"
        json: "application/json, text/javascript"
        "*": cw

      contents:
        xml: /xml/
        html: /html/
        json: /json/

      responseFields:
        xml: "responseXML"
        text: "responseText"

      converters:
        "* text": a.String
        "text html": not 0
        "text json": p.parseJSON
        "text xml": p.parseXML

      flatOptions:
        context: not 0
        url: not 0

    ajaxPrefilter: cy(cu)
    ajaxTransport: cy(cv)
    ajax: (a, c) ->
      y = (a, c, f, i) ->
        k = undefined
        s = undefined
        t = undefined
        u = undefined
        w = undefined
        y = c
        return  if v is 2
        v = 2
        h and clearTimeout(h)
        g = b
        e = i or ""
        x.readyState = (if a > 0 then 4 else 0)
        f and (u = cB(l, x, f))

        unless a >= 200 and a < 300 or a is 304
          t = y
          if not y or a
            y = "error"
            a < 0 and (a = 0)
        x.status = a
        x.statusText = "" + (c or y)
        (if k then o.resolveWith(m, [s, y, x]) else o.rejectWith(m, [x, y, t]))
        x.statusCode(r)
        r = b
        j and n.trigger("ajax" + ((if k then "Success" else "Error")), [x, l, (if k then s else t)])
        q.fireWith(m, [x, y])
        j and (n.trigger("ajaxComplete", [x, l])
        --p.active or p.event.trigger("ajaxStop")
        )
      typeof a is "object" and (c = a
      a = b
      )
      c = c or {}

      d = undefined
      e = undefined
      f = undefined
      g = undefined
      h = undefined
      i = undefined
      j = undefined
      k = undefined
      l = p.ajaxSetup({}, c)
      m = l.context or l
      n = (if m isnt l and (m.nodeType or m instanceof p) then p(m) else p.event)
      o = p.Deferred()
      q = p.Callbacks("once memory")
      r = l.statusCode or {}
      t = {}
      u = {}
      v = 0
      w = "canceled"
      x =
        readyState: 0
        setRequestHeader: (a, b) ->
          unless v
            c = a.toLowerCase()
            a = u[c] = u[c] or a
            t[a] = b
          this

        getAllResponseHeaders: ->
          (if v is 2 then e else null)

        getResponseHeader: (a) ->
          c = undefined
          if v is 2
            unless f
              f = {}
              f[c[1].toLowerCase()] = c[2]  while c = cl.exec(e)
            c = f[a.toLowerCase()]
          (if c is b then null else c)

        overrideMimeType: (a) ->
          v or (l.mimeType = a)
          this

        abort: (a) ->
          a = a or w
          g and g.abort(a)
          y(0, a)
          this

      o.promise(x)
      x.success = x.done
      x.error = x.fail
      x.complete = q.add
      x.statusCode = (a) ->
        if a
          b = undefined
          if v < 2
            for b of a
              r[b] = [r[b], a[b]]
          else
            b = a[x.status]
            x.always(b)
        this

      l.url = ((a or l.url) + "").replace(ck, "").replace(co, cj[1] + "//")
      l.dataTypes = p.trim(l.dataType or "*").toLowerCase().split(s)
      not l.crossDomain? and (i = cs.exec(l.url.toLowerCase())
      l.crossDomain = not (not i or i[1] is cj[1] and i[2] is cj[2] and (i[3] or ((if i[1] is "http:" then 80 else 443))) is (cj[3] or ((if cj[1] is "http:" then 80 else 443))))
      )
      l.data and l.processData and typeof l.data isnt "string" and (l.data = p.param(l.data, l.traditional))
      cz(cu, l, c, x)

      return x  if v is 2
      j = l.global
      l.type = l.type.toUpperCase()
      l.hasContent = not cn.test(l.type)
      j and p.active++ is 0 and p.event.trigger("ajaxStart")

      unless l.hasContent
        l.data and (l.url += ((if cp.test(l.url) then "&" else "?")) + l.data
        delete l.data

        )
        d = l.url

        if l.cache is not 1
          z = p.now()
          A = l.url.replace(cr, "$1_=" + z)
          l.url = A + ((if A is l.url then ((if cp.test(l.url) then "&" else "?")) + "_=" + z else ""))
      (l.data and l.hasContent and l.contentType isnt not 1 or c.contentType) and x.setRequestHeader("Content-Type", l.contentType)
      l.ifModified and (d = d or l.url
      p.lastModified[d] and x.setRequestHeader("If-Modified-Since", p.lastModified[d])
      p.etag[d] and x.setRequestHeader("If-None-Match", p.etag[d])
      )
      x.setRequestHeader("Accept", (if l.dataTypes[0] and l.accepts[l.dataTypes[0]] then l.accepts[l.dataTypes[0]] + ((if l.dataTypes[0] isnt "*" then ", " + cw + "; q=0.01" else "")) else l.accepts["*"]))

      for k of l.headers
        x.setRequestHeader k, l.headers[k]
      if not l.beforeSend or l.beforeSend.call(m, x, l) isnt not 1 and v isnt 2
        w = "abort"
        for k of
          success: 1
          error: 1
          complete: 1
          x[k] l[k]
        g = cz(cv, l, c, x)
        if g
          x.readyState = 1
          j and n.trigger("ajaxSend", [x, l])
          l.async and l.timeout > 0 and (h = setTimeout(->
            x.abort "timeout"
          , l.timeout))

          try
            v = 1
            g.send(t, y)
          catch B
            if v < 2
              y -1, B
            else
              throw B
        return x
      x.abort()

    active: 0
    lastModified: {}
    etag: {}
  )

  cD = []
  cE = /\?/
  cF = /(=)\?(?=&|$)|\?\?/
  cG = p.now()
  p.ajaxSetup(
    jsonp: "callback"
    jsonpCallback: ->
      a = cD.pop() or p.expando + "_" + cG++
      this[a] = not 0
      a
  )
  p.ajaxPrefilter("json jsonp", (c, d, e) ->
    f = undefined
    g = undefined
    h = undefined
    i = c.data
    j = c.url
    k = c.jsonp isnt not 1
    l = k and cF.test(j)
    m = k and not l and typeof i is "string" and not (c.contentType or "").indexOf("application/x-www-form-urlencoded") and cF.test(i)
    if c.dataTypes[0] is "jsonp" or l or m
      f = c.jsonpCallback = (if p.isFunction(c.jsonpCallback) then c.jsonpCallback() else c.jsonpCallback)
      g = a[f]
      (if l then c.url = j.replace(cF, "$1" + f) else (if m then c.data = i.replace(cF, "$1" + f) else k and (c.url += ((if cE.test(j) then "&" else "?")) + c.jsonp + "=" + f)))
      c.converters["script json"] = ->
        h or p.error(f + " was not called")
        h[0]

      c.dataTypes[0] = "json"
      a[f] = ->
        h = arguments_

      e.always(->
        a[f] = g
        c[f] and (c.jsonpCallback = d.jsonpCallback
        cD.push(f)
        )
        h and p.isFunction(g) and g(h[0])
        h = g = b
      )
      "script"
  )
  p.ajaxSetup(
    accepts:
      script: "text/javascript, application/javascript, application/ecmascript, application/x-ecmascript"

    contents:
      script: /javascript|ecmascript/

    converters:
      "text script": (a) ->
        p.globalEval(a)
        a
  )
  p.ajaxPrefilter("script", (a) ->
    a.cache is b and (a.cache = not 1)
    a.crossDomain and (a.type = "GET"
    a.global = not 1
    )
  )
  p.ajaxTransport("script", (a) ->
    if a.crossDomain
      c = undefined
      d = e.head or e.getElementsByTagName("head")[0] or e.documentElement
      send: (f, g) ->
        c = e.createElement("script")
        c.async = "async"
        a.scriptCharset and (c.charset = a.scriptCharset)
        c.src = a.url
        c.onload = c.onreadystatechange = (a, e) ->
          if e or not c.readyState or /loaded|complete/.test(c.readyState)
            c.onload = c.onreadystatechange = null
            d and c.parentNode and d.removeChild(c)
            c = b
            e or g(200, "success")

        d.insertBefore(c, d.firstChild)

      abort: ->
        c and c.onload(0, 1)
  )

  cH = undefined
  cI = (if a.ActiveXObject then ->
    for a of cH
      cH[a] 0, 1
   else not 1)
  cJ = 0
  p.ajaxSettings.xhr = (if a.ActiveXObject then ->
    not @isLocal and cK() or cL()
   else cK)
  (a) ->
    p.extend p.support,
      ajax: !!a
      cors: !!a and "withCredentials" of a

  (p.ajaxSettings.xhr())
  p.support.ajax and p.ajaxTransport((c) ->
    if not c.crossDomain or p.support.cors
      d = undefined
      send: (e, f) ->
        g = undefined
        h = undefined
        i = c.xhr()
        (if c.username then i.open(c.type, c.url, c.async, c.username, c.password) else i.open(c.type, c.url, c.async))
        if c.xhrFields
          for h of c.xhrFields
            i[h] = c.xhrFields[h]
        c.mimeType and i.overrideMimeType and i.overrideMimeType(c.mimeType)
        not c.crossDomain and not e["X-Requested-With"] and (e["X-Requested-With"] = "XMLHttpRequest")

        try
          for h of e
            i.setRequestHeader h, e[h]
        i.send(c.hasContent and c.data or null)
        d = (a, e) ->
          h = undefined
          j = undefined
          k = undefined
          l = undefined
          m = undefined
          try
            if d and (e or i.readyState is 4)
              d = b
              g and (i.onreadystatechange = p.noop
              cI and delete cH[g]

              )

              unless e
                h = i.status
                k = i.getAllResponseHeaders()
                l = {}
                m = i.responseXML
                m and m.documentElement and (l.xml = m)

                try
                  l.text = i.responseText
                try
                  j = i.statusText
                catch n
                  j = ""
                (if not h and c.isLocal and not c.crossDomain then h = (if l.text then 200 else 404) else h is 1223 and (h = 204))
          catch o
            e or f(-1, o)
          l and f(h, j, l, k)

        (if c.async then (if i.readyState is 4 then setTimeout(d, 0) else (g = ++cJ
        cI and (cH or (cH = {}
        p(a).unload(cI)
        )
        cH[g] = d
        )
        i.onreadystatechange = d
        )) else d())

      abort: ->
        d and d(0, 1)
  )

  cM = undefined
  cN = undefined
  cO = /^(?:toggle|show|hide)$/
  cP = new RegExp("^(?:([-+])=|)(" + q + ")([a-z%]*)$", "i")
  cQ = /queueHooks$/
  cR = [cX]
  cS = "*": [(a, b) ->
    c = undefined
    d = undefined
    e = undefined
    f = @createTween(a, b)
    g = cP.exec(b)
    h = f.cur()
    i = +h or 0
    j = 1
    if g
      c = +g[2]
      d = g[3] or ((if p.cssNumber[a] then "" else "px"))

      if d isnt "px" and i
        i = p.css(f.elem, a, not 0) or c or 1
        loop
          e = j = j or ".5"
          i = i / j
          p.style(f.elem, a, i + d)
          j = f.cur() / h
          break unless j isnt 1 and j isnt e
      f.unit = d
      f.start = i
      f.end = (if g[1] then i + (g[1] + 1) * c else c)
    f
  ]
  p.Animation = p.extend(cV,
    tweener: (a, b) ->
      (if p.isFunction(a) then (b = a
      a = ["*"]
      ) else a = a.split(" "))
      c = undefined
      d = 0
      e = a.length
      while d < e
        c = a[d]
        cS[c] = cS[c] or []
        cS[c].unshift(b)
        d++

    prefilter: (a, b) ->
      (if b then cR.unshift(a) else cR.push(a))
  )
  p.Tween = cY
  cY:: =
    constructor: cY
    init: (a, b, c, d, e, f) ->
      @elem = a
      @prop = c
      @easing = e or "swing"
      @options = b
      @start = @now = @cur()
      @end = d
      @unit = f or ((if p.cssNumber[c] then "" else "px"))

    cur: ->
      a = cY.propHooks[@prop]
      (if a and a.get then a.get(this) else cY.propHooks._default.get(this))

    run: (a) ->
      b = undefined
      c = cY.propHooks[@prop]
      @pos = b = p.easing[@easing](a, @options.duration * a, 0, 1, @options.duration)
      @now = (@end - @start) * b + @start
      @options.step and @options.step.call(@elem, @now, this)
      (if c and c.set then c.set(this) else cY.propHooks._default.set(this))
      this

  cY::init:: = cY::
  cY.propHooks = _default:
    get: (a) ->
      b = undefined
      (if not a.elem[a.prop]? or !!a.elem.style and a.elem.style[a.prop]? then (b = p.css(a.elem, a.prop, not 1, "")
      (if not b or b is "auto" then 0 else b)
      ) else a.elem[a.prop])

    set: (a) ->
      (if p.fx.step[a.prop] then p.fx.step[a.prop](a) else (if a.elem.style and (a.elem.style[p.cssProps[a.prop]]? or p.cssHooks[a.prop]) then p.style(a.elem, a.prop, a.now + a.unit) else a.elem[a.prop] = a.now))

  cY.propHooks.scrollTop = cY.propHooks.scrollLeft = set: (a) ->
    a.elem.nodeType and a.elem.parentNode and (a.elem[a.prop] = a.now)

  p.each(["toggle", "show", "hide"], (a, b) ->
    c = p.fn[b]
    p.fn[b] = (d, e, f) ->
      (if not d? or typeof d is "boolean" or not a and p.isFunction(d) and p.isFunction(e) then c.apply(this, arguments_) else @animate(cZ(b, not 0), d, e, f))
  )
  p.fn.extend(
    fadeTo: (a, b, c, d) ->
      @filter(bY).css("opacity", 0).show().end().animate
        opacity: b
      , a, c, d

    animate: (a, b, c, d) ->
      e = p.isEmptyObject(a)
      f = p.speed(b, c, d)
      g = ->
        b = cV(this, p.extend({}, a), f)
        e and b.stop(not 0)

      (if e or f.queue is not 1 then @each(g) else @queue(f.queue, g))

    stop: (a, c, d) ->
      e = (a) ->
        b = a.stop
        delete a.stop

        b(d)

      typeof a isnt "string" and (d = c
      c = a
      a = b
      )
      c and a isnt not 1 and @queue(a or "fx", [])
      @each(->
        b = not 0
        c = a? and a + "queueHooks"
        f = p.timers
        g = p._data(this)
        if c
          g[c] and g[c].stop and e(g[c])
        else
          for c of g
            g[c] and g[c].stop and cQ.test(c) and e(g[c])
        c = f.length
        while c--
          f[c].elem is this and (not a? or f[c].queue is a) and (f[c].anim.stop(d)
          b = not 1
          f.splice(c, 1)
          )
        (b or not d) and p.dequeue(this, a)
      )
  )
  p.each(
    slideDown: cZ("show")
    slideUp: cZ("hide")
    slideToggle: cZ("toggle")
    fadeIn:
      opacity: "show"

    fadeOut:
      opacity: "hide"

    fadeToggle:
      opacity: "toggle"
  , (a, b) ->
    p.fn[a] = (a, c, d) ->
      @animate b, a, c, d
  )
  p.speed = (a, b, c) ->
    d = (if a and typeof a is "object" then p.extend({}, a) else
      complete: c or not c and b or p.isFunction(a) and a
      duration: a
      easing: c and b or b and not p.isFunction(b) and b
    )
    d.duration = (if p.fx.off then 0 else (if typeof d.duration is "number" then d.duration else (if d.duration of p.fx.speeds then p.fx.speeds[d.duration] else p.fx.speeds._default)))
    d.queue = "fx"  if not d.queue? or d.queue is not 0
    d.old = d.complete
    d.complete = ->
      p.isFunction(d.old) and d.old.call(this)
      d.queue and p.dequeue(this, d.queue)

    d

  p.easing =
    linear: (a) ->
      a

    swing: (a) ->
      .5 - Math.cos(a * Math.PI) / 2

  p.timers = []
  p.fx = cY::init
  p.fx.tick = ->
    a = undefined
    b = p.timers
    c = 0
    while c < b.length
      a = b[c]
      not a() and b[c] is a and b.splice(c--, 1)
      c++
    b.length or p.fx.stop()

  p.fx.timer = (a) ->
    a() and p.timers.push(a) and not cN and (cN = setInterval(p.fx.tick, p.fx.interval))

  p.fx.interval = 13
  p.fx.stop = ->
    clearInterval(cN)
    cN = null

  p.fx.speeds =
    slow: 600
    fast: 200
    _default: 400

  p.fx.step = {}
  p.expr and p.expr.filters and (p.expr.filters.animated = (a) ->
    p.grep(p.timers, (b) ->
      a is b.elem
    ).length
  )

  c$ = /^(?:body|html)$/i
  p.fn.offset = (a) ->
    if arguments_.length
      return (if a is b then this else @each((b) ->
        p.offset.setOffset this, a, b
      ))
    c = undefined
    d = undefined
    e = undefined
    f = undefined
    g = undefined
    h = undefined
    i = undefined
    j = undefined
    k = undefined
    l = undefined
    m = this[0]
    n = m and m.ownerDocument
    return  unless n
    (if (e = n.body) is m then p.offset.bodyOffset(m) else (d = n.documentElement
    (if p.contains(d, m) then (c = m.getBoundingClientRect()
    f = c_(n)
    g = d.clientTop or e.clientTop or 0
    h = d.clientLeft or e.clientLeft or 0
    i = f.pageYOffset or d.scrollTop
    j = f.pageXOffset or d.scrollLeft
    k = c.top + i - g
    l = c.left + j - h

      top: k
      left: l

    ) else
      top: 0
      left: 0
    )
    ))

  p.offset =
    bodyOffset: (a) ->
      b = a.offsetTop
      c = a.offsetLeft
      p.support.doesNotIncludeMarginInBodyOffset and (b += parseFloat(p.css(a, "marginTop")) or 0
      c += parseFloat(p.css(a, "marginLeft")) or 0
      )

        top: b
        left: c

    setOffset: (a, b, c) ->
      d = p.css(a, "position")
      d is "static" and (a.style.position = "relative")
      e = p(a)
      f = e.offset()
      g = p.css(a, "top")
      h = p.css(a, "left")
      i = (d is "absolute" or d is "fixed") and p.inArray("auto", [g, h]) > -1
      j = {}
      k = {}
      l = undefined
      m = undefined
      (if i then (k = e.position()
      l = k.top
      m = k.left
      ) else (l = parseFloat(g) or 0
      m = parseFloat(h) or 0
      ))
      p.isFunction(b) and (b = b.call(a, c, f))
      b.top? and (j.top = b.top - f.top + l)
      b.left? and (j.left = b.left - f.left + m)
      (if "using" of b then b.using.call(a, j) else e.css(j))

  p.fn.extend(
    position: ->
      return  unless this[0]
      a = this[0]
      b = @offsetParent()
      c = @offset()
      d = (if c$.test(b[0].nodeName) then
        top: 0
        left: 0
       else b.offset())
      c.top -= parseFloat(p.css(a, "marginTop")) or 0
      c.left -= parseFloat(p.css(a, "marginLeft")) or 0
      d.top += parseFloat(p.css(b[0], "borderTopWidth")) or 0
      d.left += parseFloat(p.css(b[0], "borderLeftWidth")) or 0

        top: c.top - d.top
        left: c.left - d.left

    offsetParent: ->
      @map ->
        a = @offsetParent or e.body
        a = a.offsetParent  while a and not c$.test(a.nodeName) and p.css(a, "position") is "static"
        a or e.body

  )
  p.each(
    scrollLeft: "pageXOffset"
    scrollTop: "pageYOffset"
  , (a, c) ->
    d = /Y/.test(c)
    p.fn[a] = (e) ->
      p.access this, ((a, e, f) ->
        g = c_(a)
        return (if g then (if c of g then g[c] else g.document.documentElement[e]) else a[e])  if f is b
        (if g then g.scrollTo((if d then p(g).scrollLeft() else f), (if d then f else p(g).scrollTop())) else a[e] = f)
      ), a, e, arguments_.length, null
  )
  p.each(
    Height: "height"
    Width: "width"
  , (a, c) ->
    p.each
      padding: "inner" + a
      content: c
      "": "outer" + a
    , (d, e) ->
      p.fn[e] = (e, f) ->
        g = arguments_.length and (d or typeof e isnt "boolean")
        h = d or ((if e is not 0 or f is not 0 then "margin" else "border"))
        p.access this, ((c, d, e) ->
          f = undefined
          (if p.isWindow(c) then c.document.documentElement["client" + a] else (if c.nodeType is 9 then (f = c.documentElement
          Math.max(c.body["scroll" + a], f["scroll" + a], c.body["offset" + a], f["offset" + a], f["client" + a])
          ) else (if e is b then p.css(c, d, e, h) else p.style(c, d, e, h))))
        ), c, (if g then e else b), g

  )
  a.jQuery = a.$ = p
  typeof define is "function" and define.amd and define.amd.jQuery and define("jquery", [], ->
    p
  )
) window
