# ISA Design

This is a design where we have `4` registers in CPU and each register has `1` byte. Therefore we need `2` bits to represent the register id.

The main memory is also `256` bytes in size, so we can use the data inside a single register to access/update the data in the main memory.

Note:

* `$pc`: Program Counter. Not necessarily `1` byte in size. Could have more bits.
* `$cmp`: Compare Register. Only have `1` bit. Could be written by `cmp` instruction, and will be used by `br` instruction.
* `mem`: The Main Memory, contains `256` bytes.

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
      <td colspan="6" align="center"><code>imm (signed)</code></td>
      <td><code>$pc = $pc + imm</code></td>
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
      <td>Load Immediate High</td>
      <td><code>1</code></td>
      <td><code>0</code></td>
      <td><code>1</code></td>
      <td colspan="2" align="center"><code>$a</code></td>
      <td colspan="4" align="center"><code>imm</code></td>
      <td><code>$a[4:7] = imm</code></td>
    </tr>
    <tr>
      <td>Load Immediate Low</td>
      <td><code>1</code></td>
      <td><code>0</code></td>
      <td><code>0</code></td>
      <td colspan="2" align="center"><code>$a</code></td>
      <td colspan="4" align="center"><code>imm</code></td>
      <td><code>$a[0:3] = imm</code></td>
    </tr>
    <tr>
      <td>Shift Right Immediate</td>
      <td><code>0</code></td>
      <td><code>1</code></td>
      <td><code>1</code></td>
      <td><code>0</code></td>
      <td colspan="2" align="center"><code>$a</code></td>
      <td colspan="3" align="center"><code>shamt</code></td>
      <td><code>$a = $a >> shamt</code></td>
    </tr>
    <tr>
      <td>Shift Left Immediate</td>
      <td><code>0</code></td>
      <td><code>1</code></td>
      <td><code>1</code></td>
      <td><code>1</code></td>
      <td colspan="2" align="center"><code>$a</code></td>
      <td colspan="3" align="center"><code>shamt</code></td>
      <td><code>$a = $a << shamt</code></td>
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
      <td>Compare</td>
      <td><code>0</code></td>
      <td><code>0</code></td>
      <td><code>1</code></td>
      <td><code>1</code></td>
      <td><code>0</code></td>
      <td colspan="2" align="center"><code>$a</code></td>
      <td colspan="2" align="center"><code>$b</code></td>
      <td><code>$cmp = $a == $b</code></td>
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
      <td><code>$pc = $cmp ? $a : $pc</code></td>
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