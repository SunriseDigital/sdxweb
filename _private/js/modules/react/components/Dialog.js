import React, { Component } from 'react'
import Draggable from 'react-draggable';

export default class Dialog extends Component {
  constructor(props){
    super(props);

    this.state = {
      isDisplay: false
    }
  }

  getWindowPosition(){
    const width = window.innerWidth
    || document.documentElement.clientWidth
    || document.body.clientWidth;

    const height = window.innerHeight
    || document.documentElement.clientHeight
    || document.body.clientHeight;

    const doc = document.documentElement;
    const left = (window.pageXOffset || doc.scrollLeft) - (doc.clientLeft || 0);
    const top = (window.pageYOffset || doc.scrollTop)  - (doc.clientTop || 0);

    return {width: width, height: height, top: top, left: left}
  }

  show(){
    this.setState({isDisplay: true});
  }

  hide(){
    this.setState({isDisplay: false});
  }

  render() {

    const panelStyle = {
      width: this.props.size.width + "px",
      height: this.props.size.height + "px",
      display: this.state.isDisplay ? "block" : "none",
      position: 'absolute',
      zIndex:"10000",
    }

    if(this.props.position == 'window-center'){
      const windowPos = this.getWindowPosition();
      //ヘッダーが画面からはみ出さないようにセンターを求める。
      panelStyle.top =  Math.max((windowPos.height / 2) - (this.props.size.height / 2) + windowPos.top, windowPos.top)
      panelStyle.left = Math.max((windowPos.width / 2) - (this.props.size.width / 2) + windowPos.left, windowPos.left)
    }

    // console.log();

    return (
      <Draggable
        handle=".panel-heading"
        defaultClassName={this.props.defaultClassName}
      >
        <div style={panelStyle}>
          {this.props.children}
        </div>
      </Draggable>
    )
  }
}

Dialog.defaultProps = {
  size: {
    width: 640,
    height: 640,
  },
  isDisplay: false,
  position: 'window-center',
}
