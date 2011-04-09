# About

Node module/wrapper for Google's fast compressor/decompressor: http://code.google.com/p/snappy/

Snappy is a compression/decompression library. It does not aim for maximum compression, or compatibility with any other compression library; instead, it aims for very high speeds and reasonable compression. For instance, compared to the fastest mode of zlib, Snappy is an order of magnitude faster for most inputs, but the resulting compressed files are anywhere from 20% to 100% bigger. On a single core of a Core i7 processor in 64-bit mode, Snappy compresses at about 250 MB/sec or more and decompresses at about 500 MB/sec or more.

Snappy is widely used inside Google, in everything from BigTable and MapReduce to our internal RPC systems. (Snappy has previously been referred to as “Zippy” in some presentations and the likes.)

# Installation
- Grab the latest Snappy build and install it on your system:
  - http://code.google.com/p/snappy/
- Install coffee-script (http://jashkenas.github.com/coffee-script/)
  - npm install coffee-script
- Edit wscript and edit change the snappy_home-variable to the path were you've installed snappy_home
- Build and install node-snappy
  - node-waf configure install

# Examples
## String
    snappy = require('./snappy');
    snappy.compress('string to compress', function(err, compressed){
      // result will be string instead of Buffer
      snappy.decompress(compressed, snappy.parsers.string, function(err, result){
        console.log(result);
      }
    }

## JSON
    snappy = require('./snappy');
    // Snappy automatically convert json to a string
    snappy.compress({"foo": "bar"}, function(err, compressed){
      // result will be json instead of Buffer
      snappy.decompress(compressed, snappy.parsers.json, function(err, result){
        console.log(result["foo"]);
      }
    }

For more examples of the api, see test.coffee

# License
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
