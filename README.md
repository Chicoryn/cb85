# `cb85`

Cython implemention of the CPython `base64.b85encode` and `base64.b85decode` functions to achieve better performance. The API is not 1:1 because I did not need all obscure functionality related to Base85 encoding.

I wrote this library because I needed a way to store binary data in JSON, but if you try to store binary data in JSON without any encoding your file size will blow up due to the need to escape non-printable characters.

## Install

```
python -m pip install cb85
```

### From source

```
make build && make test
python -m pip install dist/cb85-*.whl
```

## Benchmark

This library is between 30x to 50x faster depending on the size of the input
data. You can run these benchmarks yourself by running `make bench`:

|             | CPython (usec) | `cb85` (usec) |
|        ---: |           ---: |          ---: |
| `b85encode` |           15.9 |         0.481 |
| `b85decode` |           26.6 |         0.474 |

## Example

```python
from cb85 import b85decode, b85encode

print(b85encode(b'a')) # b'VE_OC'
print(b85decode(b'VE_OC')) # b'a\x00\x00\x00'
```
