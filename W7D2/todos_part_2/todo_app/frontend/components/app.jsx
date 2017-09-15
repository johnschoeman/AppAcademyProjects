import React from 'react';
import ReactDOM from 'react-dom';
import TodoListContainer from "./todo_list/todo_list_container";

const App = () => {
  return (
    <div>
      <h1>Todo App</h1>
      <TodoListContainer />
    </div>
  );
};

export default App;
