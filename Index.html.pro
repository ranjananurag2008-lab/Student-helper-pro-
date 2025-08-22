<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Ultimate Supreme Final Boss App</title>
<style>
body{margin:0;padding:0;font-family:'Segoe UI',Tahoma,Geneva,Verdana,sans-serif;background:#f0f0f5;color:#333;transition:0.3s;}
header{background:#1a1a2e;color:white;text-align:center;padding:20px 0;font-size:1.8em;font-weight:bold;}
nav{display:flex;justify-content:center;flex-wrap:wrap;background:#162447;}
nav button{padding:12px 20px;margin:3px;font-size:1em;cursor:pointer;border:none;border-radius:5px;background:#1f4068;color:white;transition:0.3s;}
nav button:hover{background:#162447;}
.section{display:none;padding:15px;}
.section.active{display:block;}
input,textarea{padding:10px;border-radius:5px;border:1px solid #aaa;width:100%;margin-bottom:10px;}
button{border:none;border-radius:5px;cursor:pointer;transition:0.3s;}
button:hover{opacity:0.85;}
.list-item{background:white;padding:10px;margin-bottom:5px;border-left:4px solid #1a1a2e;border-radius:5px;word-wrap:break-word;display:flex;justify-content:space-between;align-items:center;}
.dark-mode{background:#1a1a2e;color:#f0f0f5;}
.dark-mode .list-item,.dark-mode a{background:#333;color:white;border-left:4px solid #f0f0f5;}
.dark-mode input,.dark-mode textarea{background:#333;color:white;border:1px solid #555;}
@media(max-width:480px){nav button{flex:1 1 45%;margin:2px;font-size:0.9em;}}
.calc input{width:100%;padding:12px;margin-bottom:10px;font-size:1.2em;text-align:right;border-radius:5px;border:1px solid #aaa;}
.calc button{width:22%;margin:1%;padding:12px;font-size:1.1em;cursor:pointer;border-radius:5px;border:none;background:#1f4068;color:white;transition:0.2s;}
.calc button:hover{background:#162447;}
.calc-history{max-height:150px;overflow-y:auto;margin-top:10px;border:1px solid #aaa;padding:5px;border-radius:5px;background:#e0e0e0;}
.calc-history div{padding:5px;cursor:pointer;border-bottom:1px solid #ccc;}
.calc-history div:hover{background:#d0d0d0;}
a{display:block;margin-bottom:5px;color:#1f4068;text-decoration:none;}
a:hover{text-decoration:underline;}
</style>
</head>
<body>

<header>Ultimate Supreme Final Boss App</header>

<nav>
  <button onclick="showSection('login')">Login</button>
  <button onclick="showSection('calculator')">Calculator</button>
  <button onclick="showSection('notes')">Notes</button>
  <button onclick="showSection('todo')">To-Do</button>
  <button onclick="showSection('resources')">Resources</button>
  <button onclick="toggleDarkMode()">Dark/Light Mode</button>
</nav>

<!-- Login -->
<div id="login" class="section active">
  <input type="text" id="username" placeholder="Username">
  <input type="password" id="password" placeholder="Password">
  <button onclick="login()">Login</button>
</div>

<!-- Calculator -->
<div id="calculator" class="section">
  <div class="calc">
    <input type="text" id="calcInput" placeholder="0" readonly>
    <div>
      <button onclick="appendCalc('7')">7</button>
      <button onclick="appendCalc('8')">8</button>
      <button onclick="appendCalc('9')">9</button>
      <button onclick="appendCalc('/')">/</button>
    </div>
    <div>
      <button onclick="appendCalc('4')">4</button>
      <button onclick="appendCalc('5')">5</button>
      <button onclick="appendCalc('6')">6</button>
      <button onclick="appendCalc('*')">*</button>
    </div>
    <div>
      <button onclick="appendCalc('1')">1</button>
      <button onclick="appendCalc('2')">2</button>
      <button onclick="appendCalc('3')">3</button>
      <button onclick="appendCalc('-')">-</button>
    </div>
    <div>
      <button onclick="appendCalc('0')">0</button>
      <button onclick="appendCalc('.')">.</button>
      <button onclick="calculate()">=</button>
      <button onclick="appendCalc('+')">+</button>
    </div>
    <div>
      <button onclick="appendCalc('(')">(</button>
      <button onclick="appendCalc(')')">)</button>
      <button onclick="appendCalc('%')">%</button>
      <button onclick="appendCalc('**')">^</button>
    </div>
    <button onclick="clearCalc()" style="width:100%; background:#e94560; color:white;">Clear</button>
    <div class="calc-history" id="calcHistory"></div>
  </div>
</div>

<!-- Notes -->
<div id="notes" class="section">
  <textarea id="noteText" placeholder="Write your notes here..."></textarea>
  <button onclick="addNote()">Add Note</button>
  <div id="noteList"></div>
</div>

<!-- To-Do -->
<div id="todo" class="section">
  <input type="text" id="todoInput" placeholder="Add a task">
  <button onclick="addTodo()">Add Task</button>
  <div id="todoList"></div>
</div>

<!-- Resources -->
<div id="resources" class="section">
  <a href="https://www.freecodecamp.org/" target="_blank">FreeCodeCamp</a>
  <a href="https://www.khanacademy.org/" target="_blank">Khan Academy</a>
  <a href="https://www.gutenberg.org/" target="_blank">Project Gutenberg (Free Books)</a>
  <a href="https://openstax.org/" target="_blank">OpenStax Textbooks</a>
</div>

<script>
// Sections
function showSection(id){
  document.querySelectorAll('.section').forEach(s=>s.classList.remove('active'));
  document.getElementById(id).classList.add('active');
}

// Dark Mode
function toggleDarkMode(){
  document.body.classList.toggle('dark-mode');
}

// Login
function login(){
  const user=document.getElementById('username').value;
  const pass=document.getElementById('password').value;
  if(user==='admin' && pass==='1234'){
    alert('Login Successful!');
    showSection('calculator');
  } else { alert('Invalid credentials'); }
}

// Calculator
let calcInput=document.getElementById('calcInput');
let calcHistoryDiv=document.getElementById('calcHistory');
function appendCalc(val){ if(calcInput) calcInput.value+=val; }
function clearCalc(){ if(calcInput) calcInput.value=''; }
function calculate(){
  if(!calcInput) return;
  try{
    let res=eval(calcInput.value);
    calcHistoryDiv.innerHTML+=`<div onclick="reuseCalc('${calcInput.value}')">${calcInput.value} = ${res}</div>`;
    calcInput.value=res;
  } catch(e){ alert('Invalid Input'); }
}
function reuseCalc(expr){ calcInput.value=expr; }
document.addEventListener('keydown',e=>{
  if(calcInput && '0123456789+-*/%.()'.includes(e.key)) appendCalc(e.key);
  else if(e.key==='Enter') calculate();
  else if(e.key==='Backspace') calcInput.value=calcInput.value.slice(0,-1);
});

// Notes
function addNote(){
  const text=document.getElementById('noteText').value;
  if(text){
    const div=document.createElement('div');
    div.className='list-item';
    div.innerHTML=`<span>${text}</span> <button onclick="editNote(this)">Edit</button> <button onclick="deleteNote(this)">Delete</button>`;
    document.getElementById('noteList').appendChild(div);
    document.getElementById('noteText').value='';
    saveNotes();
  }
}
function editNote(btn){
  const span=btn.parentElement.querySelector('span');
  const newText=prompt('Edit Note:',span.innerText);
  if(newText){ span.innerText=newText; saveNotes(); }
}
function deleteNote(btn){ btn.parentElement.remove(); saveNotes(); }
function saveNotes(){
  const notes=Array.from(document.querySelectorAll('#noteList .list-item span')).map(s=>s.innerText);
  localStorage.setItem('notes',JSON.stringify(notes));
}
function loadNotes(){
  const notes=JSON.parse(localStorage.getItem('notes')||'[]');
  notes.forEach(n=>{
    const div=document.createElement('div');
    div.className='list-item';
    div.innerHTML=`<span>${n}</span> <button onclick="editNote(this)">Edit</button> <button onclick="deleteNote(this)">Delete</button>`;
    document.getElementById('noteList').appendChild(div);
  });
}
loadNotes();

// To-Do
function addTodo(){
  const text=document.getElementById('todoInput').value;
  if(text){
    const div=document.createElement('div');
    div.className='list-item';
    div.innerHTML=`<span>${text}</span> <button onclick="editTodo(this)">Edit</button> <button onclick="deleteTodo(this)">Delete</button>`;
    document.getElementById('todoList').appendChild(div);
    document.getElementById('todoInput').value='';
    saveTodos();
  }
}
function editTodo(btn){
  const span=btn.parentElement.querySelector('span');
  const newText=prompt('Edit Task:',span.innerText);
  if(newText){ span.innerText=newText; saveTodos(); }
}
function deleteTodo(btn){ btn.parentElement.remove(); saveTodos(); }
function saveTodos(){
  const todos=Array.from(document.querySelectorAll('#todoList .list-item span')).map(s=>s.innerText);
  localStorage.setItem('todos',JSON.stringify(todos));
}
function loadTodos(){
  const todos=JSON.parse(localStorage.getItem('todos')||'[]');
  todos.forEach(t=>{
    const div=document.createElement('div');
    div.className='list-item';
    div.innerHTML=`<span>${t}</span> <button onclick="editTodo(this)">Edit</button> <button onclick="deleteTodo(this)">Delete</button>`;
    document.getElementById('todoList').appendChild(div);
  });
}
loadTodos();
</script>
</body>
</html>
