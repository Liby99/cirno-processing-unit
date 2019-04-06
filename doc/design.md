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
      <th>Instr</th>
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
      <td><code>jmpi</code></td>
      <td><code>1</code></td>
      <td><code>1</code></td>
      <td><code>1</code></td>
      <td colspan="6" align="center"><code>imm (signed)</code></td>
      <td><code>$pc = $pc + imm</code></td>
    </tr>
    <tr>
      <td>And Immediate</td>
      <td><code>andi</code></td>
      <td><code>1</code></td>
      <td><code>1</code></td>
      <td><code>0</code></td>
      <td colspan="2" align="center"><code>$a</code></td>
      <td colspan="4" align="center"><code>imm</code></td>
      <td><code>$a = $a & imm</code></td>
    </tr>
    <tr>
      <td>Move Immediate High</td>
      <td><code>movih</code></td>
      <td><code>1</code></td>
      <td><code>0</code></td>
      <td><code>1</code></td>
      <td colspan="2" align="center"><code>$a</code></td>
      <td colspan="4" align="center"><code>imm</code></td>
      <td><code>$a[4:7] = imm</code></td>
    </tr>
    <tr>
      <td>Move Immediate Low</td>
      <td><code>movil</code></td>
      <td><code>1</code></td>
      <td><code>0</code></td>
      <td><code>0</code></td>
      <td colspan="2" align="center"><code>$a</code></td>
      <td colspan="4" align="center"><code>imm</code></td>
      <td><code>$a[0:3] = imm</code></td>
    </tr>
    <tr>
      <td>Shift Right Immediate</td>
      <td><code>shri</code></td>
      <td><code>0</code></td>
      <td><code>1</code></td>
      <td><code>1</code></td>
      <td><code>1</code></td>
      <td colspan="2" align="center"><code>$a</code></td>
      <td colspan="3" align="center"><code>shamt</code></td>
      <td><code>$a = $a >> shamt</code></td>
    </tr>
    <tr>
      <td>Shift Left Immediate</td>
      <td><code>shli</code></td>
      <td><code>0</code></td>
      <td><code>1</code></td>
      <td><code>1</code></td>
      <td><code>0</code></td>
      <td colspan="2" align="center"><code>$a</code></td>
      <td colspan="3" align="center"><code>shamt</code></td>
      <td><code>$a = $a << shamt</code></td>
    </tr>
    <tr>
      <td>Branch Immediate</td>
      <td><code>bri</code></td>
      <td><code>0</code></td>
      <td><code>1</code></td>
      <td><code>0</code></td>
      <td><code>1</code></td>
      <td><code>1</code></td>
      <td colspan="4" align="center"><code>imm (signed)</code></td>
      <td><code>if cmp: $pc = $pc + imm</code></td>
    </tr>
    <tr>
      <td>Shift Register</td>
      <td><code>sh</code></td>
      <td><code>0</code></td>
      <td><code>1</code></td>
      <td><code>0</code></td>
      <td><code>1</code></td>
      <td><code>0</code></td>
      <td colspan="2" align="center"><code>$a</code></td>
      <td colspan="2" align="center"><code>$b</code></td>
      <td>
        <code>
          shamt = $b[2:0]<br />
          if $b[3]:<br />
          &nbsp; $a = $a << shamt<br />
          else:<br />
          &nbsp; $a = $a >> shamt
        </code>
      </td>
    </tr>
    <tr>
      <td>Store</td>
      <td><code>sb</code></td>
      <td><code>0</code></td>
      <td><code>1</code></td>
      <td><code>0</code></td>
      <td><code>0</code></td>
      <td><code>1</code></td>
      <td colspan="2" align="center"><code>$a</code></td>
      <td colspan="2" align="center"><code>$b</code></td>
      <td><code>mem[$b] = $a</code></td>
    </tr>
    <tr>
      <td>Load</td>
      <td><code>lb</code></td>
      <td><code>0</code></td>
      <td><code>1</code></td>
      <td><code>0</code></td>
      <td><code>0</code></td>
      <td><code>0</code></td>
      <td colspan="2" align="center"><code>$a</code></td>
      <td colspan="2" align="center"><code>$b</code></td>
      <td><code>$a = mem[$b]</code></td>
    </tr>
    <tr>
      <td>Move</td>
      <td><code>mov</code></td>
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
      <td><code>cmp</code></td>
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
      <td><code>add</code></td>
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
      <td><code>sub</code></td>
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
      <td><code>and</code></td>
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
      <td><code>or</code></td>
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
      <td><code>xor</code></td>
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
      <td><code>incr</code></td>
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
      <td><code>jmpr</code></td>
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
      <td><code>br</code></td>
      <td><code>0</code></td>
      <td><code>0</code></td>
      <td><code>0</code></td>
      <td><code>0</code></td>
      <td><code>0</code></td>
      <td><code>0</code></td>
      <td><code>1</code></td>
      <td colspan="2" align="center"><code>$a</code></td>
      <td><code>if $cmp: $pc = $a</code></td>
    </tr>
    <tr>
      <td>Nil Operation</td>
      <td><code>nil</code></td>
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