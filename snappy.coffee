###
  Copyright (c) 2011 David Björklund

  Permission is hereby granted, free of charge, to any person obtaining a copy
  of this software and associated documentation files (the "Software"), to deal
  in the Software without restriction, including without limitation the rights
  to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
  copies of the Software, and to permit persons to whom the Software is
  furnished to do so, subject to the following conditions:

  The above copyright notice and this permission notice shall be included in
  all copies or substantial portions of the Software.

  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
  OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
  THE SOFTWARE.
###

binding = require('./build/default/binding')

# Parsers
exports.parsers = parsers =
  json: (buffer) ->
    return JSON.parse buffer
  string: (buffer) ->
    return buffer.toString("utf8")
  raw: (buffer)->
    return buffer

# Compress
exports.compress = (input, callback) ->
  unless typeof input is 'string' or Buffer.isBuffer input
    input = JSON.stringify(input)
  binding.compress(input, callback)

exports.compressSync = (input, callback) ->
  unless typeof input is 'string' or Buffer.isBuffer input
    input = JSON.stringify(input)
  binding.compressSync(input, callback)

# isValidCompressed
exports.isValidCompressed = (input, callback) ->
  binding.isValidCompressed(input, callback)

exports.isValidCompressedSync = (input, callback) ->
  binding.isValidCompressedSync(input, callback)

# de-/uncompress
exports.uncompress = (compressed, callback, parse = parsers.raw) ->
  binding.uncompress(compressed, (err, data) ->
    data = parse(data) if data?
    callback(err, data)
  )
exports.decompress = exports.uncompress

exports.uncompressSync = (compressed, callback, parse = parsers.raw) ->
  binding.uncompressSync(compressed, (err, data) ->
    data = parse(data) if data?
    callback(err, data)
  )
exports.decompressSync = exports.uncompressSync
