import React, { Component } from "react";
import { render } from "react-dom";
import './App.css';
import DrawingSurface from "./DrawingSurface";

class  App extends Component {
    render() {
        return (
                <div className="App">
                <DrawingSurface />
                </div>
        );
    }
}

export default App;

const container = document.getElementById("App");
window.addEventListener('load', renderApp);
function renderApp(){
    render(<App />, container);
}
