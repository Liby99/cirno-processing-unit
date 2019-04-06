# ISA Design

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
      <td>Jump Immediate</td>
      <td><code>1</code></td>
      <td><code>1</code></td>
      <td><code>1</code></td>
      <td colspan="6" align="center"><code>imm</code></td>
      <td><code>$pc = imm</code></td>
    </tr>
    <tr>
      <td>And Immediate</td>
      <td><code>1</code></td>
      <td><code>1</code></td>
      <td><code>0</code></td>
      <td colspan="2" align="center"><code>$a</code></td>
      <td colspan="4" align="center"><code>imm</code></td>
      <td><code>$a = $a & imm</code></td>
    </tr>
    <tr>
      <td>Move Immediate High</td>
      <td><code>1</code></td>
      <td><code>0</code></td>
      <td><code>1</code></td>
      <td colspan="2" align="center"><code>$a</code></td>
      <td colspan="4" align="center"><code>imm</code></td>
      <td><code>$a[4:7] = imm</code></td>
    </tr>
    <tr>
      <td>Move Immediate Low</td>
      <td><code>1</code></td>
      <td><code>0</code></td>
      <td><code>0</code></td>
      <td colspan="2" align="center"><code>$a</code></td>
      <td colspan="4" align="center"><code>imm</code></td>
      <td><code>$a[0:3] = imm</code></td>
    </tr>
    <tr>
      <td>Shift Immediate</td>
      <td><code>0</code></td>
      <td><code>1</code></td>
      <td><code>1</code></td>
      <td><code>d</code></td>
      <td colspan="2" align="center"><code>$a</code></td>
      <td colspan="3" align="center"><code>sh</code></td>
      <td><code>$a = d ? ($a << sh) : ($a >> sh)</code></td>
    </tr>
    <tr>
      <td>Store</td>
      <td><code>0</code></td>
      <td><code>1</code></td>
      <td><code>0</code></td>
      <td><code>1</code></td>
      <td><code>1</code></td>
      <td colspan="2" align="center"><code>$a</code></td>
      <td colspan="2" align="center"><code>$b</code></td>
      <td><code>mem[$b] = $a</code></td>
    </tr>
    <tr>
      <td>Load</td>
      <td><code>0</code></td>
      <td><code>1</code></td>
      <td><code>0</code></td>
      <td><code>1</code></td>
      <td><code>0</code></td>
      <td colspan="2" align="center"><code>$a</code></td>
      <td colspan="2" align="center"><code>$b</code></td>
      <td><code>$a = mem[$b]</code></td>
    </tr>
    <tr>
      <td>Shift Right Register</td>
      <td><code>0</code></td>
      <td><code>1</code></td>
      <td><code>0</code></td>
      <td><code>0</code></td>
      <td><code>1</code></td>
      <td colspan="2" align="center"><code>$a</code></td>
      <td colspan="2" align="center"><code>$b</code></td>
      <td><code>$a = $a >> $b</code></td>
    </tr>
    <tr>
      <td>Shift Left Register</td>
      <td><code>0</code></td>
      <td><code>1</code></td>
      <td><code>0</code></td>
      <td><code>0</code></td>
      <td><code>0</code></td>
      <td colspan="2" align="center"><code>$a</code></td>
      <td colspan="2" align="center"><code>$b</code></td>
      <td><code>$a = $a << $b</code></td>
    </tr>
    <tr>
      <td>Move</td>
      <td><code>0</code></td>
      <td><code>0</code></td>
      <td><code>1</code></td>
      <td><code>1</code></td>
      <td><code>1</code></td>
      <td colspan="2" align="center"><code>$a</code></td>
      <td colspan="2" align="center"><code>$b</code></td>
      <td><code>$a = $b</code></td>
    </tr>
    <tr>
      <td>???</td>
      <td><code>0</code></td>
      <td><code>0</code></td>
      <td><code>1</code></td>
      <td><code>1</code></td>
      <td><code>0</code></td>
      <td colspan="2" align="center"><code>$a</code></td>
      <td colspan="2" align="center"><code>$b</code></td>
      <td><code>???</code></td>
    </tr>
    <tr>
      <td>Add</td>
      <td><code>0</code></td>
      <td><code>0</code></td>
      <td><code>1</code></td>
      <td><code>0</code></td>
      <td><code>1</code></td>
      <td colspan="2" align="center"><code>$a</code></td>
      <td colspan="2" align="center"><code>$b</code></td>
      <td><code>$a = $a + $b</code></td>
    </tr>
    <tr>
      <td>Sub</td>
      <td><code>0</code></td>
      <td><code>0</code></td>
      <td><code>1</code></td>
      <td><code>0</code></td>
      <td><code>0</code></td>
      <td colspan="2" align="center"><code>$a</code></td>
      <td colspan="2" align="center"><code>$b</code></td>
      <td><code>$a = $a - $b</code></td>
    </tr>
    <tr>
      <td>And</td>
      <td><code>0</code></td>
      <td><code>0</code></td>
      <td><code>0</code></td>
      <td><code>1</code></td>
      <td><code>1</code></td>
      <td colspan="2" align="center"><code>$a</code></td>
      <td colspan="2" align="center"><code>$b</code></td>
      <td><code>$a = $a & $b</code></td>
    </tr>
    <tr>
      <td>Or</td>
      <td><code>0</code></td>
      <td><code>0</code></td>
      <td><code>0</code></td>
      <td><code>1</code></td>
      <td><code>0</code></td>
      <td colspan="2" align="center"><code>$a</code></td>
      <td colspan="2" align="center"><code>$b</code></td>
      <td><code>$a = $a | $b</code></td>
    </tr>
    <tr>
      <td>Xor</td>
      <td><code>0</code></td>
      <td><code>0</code></td>
      <td><code>0</code></td>
      <td><code>0</code></td>
      <td><code>1</code></td>
      <td colspan="2" align="center"><code>$a</code></td>
      <td colspan="2" align="center"><code>$b</code></td>
      <td><code>$a = $a ^ $b</code></td>
    </tr>
    <tr>
      <td>Incr</td>
      <td><code>0</code></td>
      <td><code>0</code></td>
      <td><code>0</code></td>
      <td><code>0</code></td>
      <td><code>0</code></td>
      <td><code>1</code></td>
      <td><code>1</code></td>
      <td colspan="2" align="center"><code>$a</code></td>
      <td><code>$a++</code></td>
    </tr>
    <tr>
      <td>Jump Register</td>
      <td><code>0</code></td>
      <td><code>0</code></td>
      <td><code>0</code></td>
      <td><code>0</code></td>
      <td><code>0</code></td>
      <td><code>1</code></td>
      <td><code>0</code></td>
      <td colspan="2" align="center"><code>$a</code></td>
      <td><code>$pc = $a</code></td>
    </tr>
    <tr>
      <td>Branch if Zero</td>
      <td><code>0</code></td>
      <td><code>0</code></td>
      <td><code>0</code></td>
      <td><code>0</code></td>
      <td><code>0</code></td>
      <td><code>0</code></td>
      <td><code>1</code></td>
      <td colspan="2" align="center"><code>$a</code></td>
      <td><code>$pc = $a == 0 ? ($pc + 1) : ($pc + 2)</code></td>
    </tr>
    <tr>
      <td>Nil Operation</td>
      <td><code>0</code></td>
      <td><code>0</code></td>
      <td><code>0</code></td>
      <td><code>0</code></td>
      <td><code>0</code></td>
      <td><code>0</code></td>
      <td><code>0</code></td>
      <td><code>0</code></td>
      <td><code>0</code></td>
      <td>Nothing Happens</td>
    </tr>
  </tbody>
</table>

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