import React, { Component } from "react"
import {render}  from "react-dom"
import {Socket} from "phoenix"

class DrawingSurface extends Component {
    getRoomCode(){
        let appRoot = document.getElementById('App')
        return appRoot.getAttribute('data-room-code')

    }

    componentDidMount(){

        this.state.socket = new Socket("/drawing", {params: {token: window.userToken}})
        this.state.socket.connect()
        this.state.channel = this.state.socket.channel("room:" + this.getRoomCode(), {})
        this.state.channel.join()
            .receive("ok", resp => { console.log("Joined successfully", resp) })
            .receive("error", resp => { console.log("Unable to join", resp) })


        const Atrament = require('atrament');
        this.state.sketchpad = new Atrament(
            this.state.canvas.current,
            {
                width:640,
                height:480,
                color:this.state.color,
            }
        );
        this.state.channel.push('sketchpad_initialize');
        this.state.sketchpad.recordStrokes = true;
        this.state.sketchpad.addEventListener('strokerecorded', ({stroke}) => {
            this.state.channel.push('sketchpad_status',  {
                data: {
                    stroke: stroke,
                    color: this.state.sketchpad.color,
                    mode: this.state.sketchpad.mode
                }
            });
        });
        this.state.sketchpad.addEventListener('fillstart', ({x,y}) => {
            this.state.channel.push('sketchpad_fill',  {
                data: {
                    x: x,
                    y: y,
                    color: this.state.sketchpad.color,
                    mode: this.state.sketchpad.mode
                }
            });
        });
        this.state.channel.on("sketchpad_content_clear", data => {
            this.state.sketchpad.clear();

        });
        this.state.channel.on("sketchpad_content_update", data => {
            console.log(data)
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
        this.state.channel.on("sketchpad_content_fill", data => {
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
        this.state.channel.push('sketchpad_clear',  {} );
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
