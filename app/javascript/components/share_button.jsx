import React, { Component } from "react";
import {
  FacebookShareButton,
  TwitterShareButton,
  FacebookIcon,
  TwitterIcon,
  LineShareButton,
  LineIcon
} from "react-share";

export default class Share extends Component {
  render() {
    const size = 36;
    
    return (
      <div className="social_links">
        <TwitterShareButton url={this.props.url} title={this.props.title}>
          <TwitterIcon round size={size} />
        </TwitterShareButton>
        <FacebookShareButton url={this.props.url} quote={this.props.title}>
          <FacebookIcon round size={size} />
        </FacebookShareButton>
        <LineShareButton url={this.props.url} quote={this.props.title}>
          <LineIcon round size={size} />
        </LineShareButton>
      </div>
    );
  }
}