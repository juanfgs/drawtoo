import React, { Component } from "react"
import {render}  from "react-dom"
import socketIOClient from "socket.io-client";

class DrawingSurface extends Component {

    componentDidMount(){

        this.state.socket = socketIOClient('ws://0.0.0.0:5000/');
        const Atrament = require('atrament');
        this.state.sketchpad = new Atrament(
            this.state.canvas.current,
            {
                width:640,
                height:480,
                color:this.state.color,
            }
        );
        this.state.socket.emit('sketchpad_initialize');
        this.state.sketchpad.recordStrokes = true;
        this.state.sketchpad.addEventListener('strokerecorded', ({stroke}) => {
            this.state.socket.emit('sketchpad_status',  {
                data: {
                    stroke: stroke,
                    color: this.state.sketchpad.color,
                    mode: this.state.sketchpad.mode
                }
            });
        });
        this.state.sketchpad.addEventListener('fillstart', ({x,y}) => {
            this.state.socket.emit('sketchpad_fill',  {
                data: {
                    x: x,
                    y: y,
                    color: this.state.sketchpad.color,
                    mode: this.state.sketchpad.mode
                }
            });
        });
        this.state.socket.on("sketchpad_content_clear", data => {
            this.state.sketchpad.clear();

        });
        this.state.socket.on("sketchpad_content_update", data => {
            this.state.sketchpad.recordStrokes = false;


            let oldcolor = this.state.sketchpad.color ;
            const points = data.data.stroke.points.slice();
            const firstPoint = points.shift();

            this.state.sketchpad.color = data.data.color;
            this.state.sketchpad.color = data.data.mode;
            this.state.sketchpad.beginStroke(firstPoint.x, firstPoint.y);
             
             let prevPoint = firstPoint;
             while (points.length > 0) {
                 const point = points.shift();
                 const { x, y } = this.state.sketchpad.draw(point.x, point.y, prevPoint.x, prevPoint.y);
                 prevPoint = { x, y };
             }
             // endStroke closes the path
            this.state.sketchpad.endStroke(prevPoint.x, prevPoint.y);
            this.state.sketchpad.recordStrokes = true;
            this.state.sketchpad.color = oldcolor;
        });
        this.state.socket.on("sketchpad_content_fill", data => {
            this.state.sketchpad.recordStrokes = false;

            let oldcolor = this.state.sketchpad.color ;
            let oldmode = this.state.sketchpad.mode ;
            const points = [{x: data.data.x, y: data.data.y}];
            const firstPoint = points.shift();

            this.state.sketchpad.color = data.data.color;
            this.state.sketchpad.mode = data.data.mode;
            this.state.sketchpad.beginStroke(firstPoint.x, firstPoint.y);

             let prevPoint = firstPoint;
             while (points.length > 0) {
                 const point = points.shift();
                 const { x, y } = this.state.sketchpad.draw(point.x, point.y, prevPoint.x, prevPoint.y);
                 prevPoint = { x, y };
             }
             // endStroke closes the path
            this.state.sketchpad.endStroke(prevPoint.x, prevPoint.y);
            this.state.sketchpad.recordStrokes = true;
            this.state.sketchpad.color = oldcolor;
            this.state.sketchpad.mode = oldmode;
        });
    }

    clearCanvas(props) {
        this.state.sketchpad.clear();
        this.state.socket.emit('sketchpad_clear',  {} );
    }
    pickColor(props){
        this.state.sketchpad.color = props.target.value;
    }
    modeFill(props){
        this.state.sketchpad.mode = 'fill';
    }
    modeDraw(props){
        this.state.sketchpad.mode = 'draw';
    }
    constructor(props){
        super(props);
        this.state = {
            color: "black",
            canvas: React.createRef()
        };
        this.clearCanvas = this.clearCanvas.bind(this);
        this.pickColor = this.pickColor.bind(this);
        this.modeFill = this.modeFill.bind(this);
        this.modeDraw = this.modeDraw.bind(this);
    }

    render() {
        return (
                <div>
                <canvas ref={this.state.canvas}></canvas>
                <div id="Actions">
                <button onClick={this.clearCanvas}>clear</button>
                <input type="color" onChange={this.pickColor}></input>
                <button onClick={this.modeFill}>fill</button>
                <button onClick={this.modeDraw}>draw</button>
                </div>
                </div>
        )

    }
}

export default DrawingSurface;
