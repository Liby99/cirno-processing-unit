# ISA Design

<!-- | Function | 1 | 2 | 3 | 4 | 5 | 6 | 7 | 8 | 9 |
|--|--|-|-|-|-|-|-|-|-
| Jump     | `1` | |
| Shift | `0` | `1` | `1` |
| Store | `0` | `1` | `0` | `1` | `1` |
| Load | `0` | `1` | `0` | `1` | `0` |
| Move Hi | `0` | `1` | `0` | `0` | `1` |
| Move Low | `0` | `1` | `0` | `0` | `0` |
| Shift Right Reg  | `0` | `0` | `1` | `1` | `1` |
| Shift Left Reg  | `0` | `0` | `1` | `1` | `0` |
| Add  | `0` | `0` | `1` | `0` | `1` |
| Sub  | `0` | `0` | `1` | `0` | `0` |
| And  | `0` | `0` | `0` | `1` | `1` |
| Or  | `0` | `0` | `0` | `1` | `0` <td colspan="2">\$reg</td><td colspan="2">\$reg</td>
| Xor  | `0` | `0` | `0` | `0` | `1` |
| Incr | `0` | `0` | `0` | `0` | `0` | `1` | `1` |
| ??? | `0` | `0` | `0` | `0` | `0` | `1` | `0` |
| Branch If 0 | `0` | `0` | `0` | `0` | `0` | `0` | `1` |
| Nil  | `0` | `0` | `0` | `0` | `0` | `0` | `0` | `0` | `0` | -->

<table>
  <thead>
    <tr>
      <th>Function</th>
      <th>8</th>
      <th>7</th>
      <th>6</th>
      <th>5</th>
      <th>4</th>
      <th>3</th>
      <th>2</th>
      <th>1</th>
      <th>0</th>
      <th>Description</th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <td>Mov Immediate</td>
      <td>1</td>
      <td colspan="8" align="center">imm</td>
      <td><code>$r1 = imm</code></td>
    </tr>
    <tr>
      <td>Shift</td>
      <td>0</td>
    </tr>
    <tr>
      <td>Store</td>
    </tr>
    <tr>
      <td>Load</td>
    </tr>
  </tbody>
</table>