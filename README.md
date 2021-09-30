<img src="https://cdn.icon-icons.com/icons2/1153/PNG/512/1486564177-finance-finance-calculator_81497.png" width="110" 
     height="140" align="right" />
# ![logo](https://github.com/rikvdkleij/intellij-haskell/blob/master/logo/icon_intellij_haskell_32.png) Evalexpr
> Project made on october 2020

![rating](https://img.shields.io/badge/notation-★★★★★-brightgreen) ![visitor badge](https://visitor-badge.glitch.me/badge?page_id=eydou.evalexpr&left_color=purple&right_color=grey)

<h2> An essential calculator in haskell </h2>

<!-- TABLE OF CONTENTS -->
<h2 id="table-of-contents"> :book: Table of Contents</h2>

<details open="open">
  <summary>Table of Contents</summary>
  <ol>
    <li><a href="#about-the-project"> ➤ About The Project</a></li>
    <li><a href="#prerequisites"> ➤ Prerequisites</a></li>
    <li><a href="#folder-structure"> ➤ Folder Structure</a></li>
    <li><a href="#operators"> ➤ Operators</a></li>
    <li><a href="#Run"> ➤ Run the Program</a></li>
    <li><a href="#UnitTest"> ➤ UnitTest</a></li>
    <li><a href="#Results"> ➤ Results</a></li>
    <li><a href="#Authors"> ➤ Authors</a></li>
  </ol>
</details>

![-----------------------------------------------------](https://raw.githubusercontent.com/andreasbm/readme/master/assets/lines/rainbow.png)

<h2 id="about-the-project"> :pencil: About The Project</h2>

<p align="justify"> 
This is a program named evalexpr.
     
This project shows how the evaluation of an arithmetic expression works by handling precedence, variables, and functions.
</p>

![-----------------------------------------------------](https://raw.githubusercontent.com/andreasbm/readme/master/assets/lines/rainbow.png)


<!-- PREREQUISITES -->
<h2 id="prerequisites"> :fork_and_knife: Prerequisites</h2>
<img src="https://img.shields.io/badge/Haskell-5D4F85?style=for-the-badge&logo=haskell&logoColor=white" />

The following open source packages are used in this project:
* Stack vers.2.13

![-----------------------------------------------------](https://raw.githubusercontent.com/andreasbm/readme/master/assets/lines/rainbow.png)

<h2 id="folder-structure"> :cactus: Folder Structure</h2>

    code
    .
     ├── app
     │   └── Main.hs
     ├── funEvalExpr.cabal
     ├── Makefile
     ├── package.yaml
     ├── src
     │   ├── Calculator.hs
     │   ├── Check.hs
     │   └── Lib.hs
     ├── stack.yaml
     ├── stack.yaml.lock
     └── unitTest
         └── unit_test.bats

![-----------------------------------------------------](https://raw.githubusercontent.com/andreasbm/readme/master/assets/lines/rainbow.png)

<h2 id="Operators"> ➕ Operators</h2>

Support:
* \+ (plus)
* \- (sub)
* \* (multiplication)
* / (division)
* ^ (exponential)

works with () - parenthesis

![-----------------------------------------------------](https://raw.githubusercontent.com/andreasbm/readme/master/assets/lines/rainbow.png)

<h2 id="Run"> :computer: How to run the program ?</h2>

<p align="justify"> 
Compile the makefile (make) and add some arithmetic expression like this !
</p>
<pre>
 $> ./funEvalExpr "6 * 12 / 2 * (1 - 2 - (2 - 4 - 5) - 10) ^ 2 * (2 - 7 - 4) ^ 3"
 $> -419904.00
</pre>

![-----------------------------------------------------](https://raw.githubusercontent.com/andreasbm/readme/master/assets/lines/rainbow.png)

<h2 id="UnitTest"> :computer: How to run the Unit Test</h2>

<p align="justify"> 
 <pre>
 > make && test_run
 </pre>
Or Put the executable in the `unitTest` folder and run like this :
</p>
 <pre>
 > bats unit_test.bats
 </pre>

![-----------------------------------------------------](https://raw.githubusercontent.com/andreasbm/readme/master/assets/lines/rainbow.png)

<h2 id="Results"> 🧮 Results</h2>

| Evalexpr | Test |
| --- | --- |
| error management | 100% |
| one single unary operator | 100% |
| parenthesis | 100% |
| Mixed binary operators | 100% |
| All mixed | 100% |
| Coding style | 66.7% |

![-----------------------------------------------------](https://raw.githubusercontent.com/andreasbm/readme/master/assets/lines/rainbow.png)

## Authors

 
 :boy: **[Edouard Touch](https://github.com/Eydou)** <br>
  &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Email: <a>edouard.touch@epitech.eu</a> <br>
  &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; GitHub: <a href="https://github.com/eydou">@eydou</a> <br>
</p>
 
[6.1]: http://i.imgur.com/0o48UoR.png (Follow me !)
