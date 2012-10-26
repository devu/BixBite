/**
 * VERSION: beta 1.11
 * DATE: 2012-07-26
 * JavaScript (also available in AS3 and AS2)
 * UPDATES AND DOCS AT: http://www.greensock.com
 *
 * Copyright (c) 2008-2012, GreenSock. All rights reserved. 
 * This work is subject to the terms in http://www.greensock.com/terms_of_use.html or for 
 * Club GreenSock members, the software agreement that was issued with your membership.
 * 
 * @author: Jack Doyle, jack@greensock.com
 **/
(window._gsQueue || (window._gsQueue = [])).push( function() {

	_gsDefine("plugins.BezierPlugin", ["plugins.TweenPlugin"], function(TweenPlugin) {
		
		var BezierPlugin = function(props, priority) {
				TweenPlugin.call(this, "bezier", -1);
				this._overwriteProps.pop();
				this._func = {};
				this._round = {};
			},
			p = BezierPlugin.prototype = new TweenPlugin("bezier", 1),
			_RAD2DEG = 180 / Math.PI,
			_r1 = [],
			_r2 = [],
			_r3 = [],
			_corProps = {}, 
			Segment = function Segment(a, b, c, d) {
				this.a = a;
				this.b = b;
				this.c = c;
				this.d = d;
				this.da = d - a;
				this.ca = c - a;
				this.ba = b - a;
			},
			_correlate = ",x,y,z,left,top,right,bottom,marginTop,marginLeft,marginRight,marginBottom,paddingLeft,paddingTop,paddingRight,paddingBottom,backgroundPosition,backgroundPosition_y,",
			bezierThrough = BezierPlugin.bezierThrough = function(values, curviness, quadratic, basic, correlate, prepend) {
				var obj = {},
					props = [],
					i, p;
				correlate = (typeof(correlate) === "string") ? ","+correlate+"," : _correlate;
				if (curviness == null) {
					curviness = 1;
				}
				for (p in values[0]) {
					props.push(p);
				}
				_r1.length = _r2.length = _r3.length = 0;
				i = props.length;
				while (--i > -1) {
					p = props[i];
					_corProps[p] = (correlate.indexOf(","+p+",") !== -1);
					obj[p] = _parseAnchors(values, p, _corProps[p], prepend);
				}
				i = _r1.length;
				while (--i > -1) {
					_r1[i] = Math.sqrt(_r1[i]);
					_r2[i] = Math.sqrt(_r2[i]);
				}
				if (!basic) {
					i = props.length;
					while (--i > -1) {
						if (_corProps[p]) {
							a = obj[props[i]];
							l = a.length - 1;
							for (j = 0; j < l; j++) {
								r = a[j+1].da / _r2[j] + a[j].da / _r1[j]; 
								_r3[j] = (_r3[j] || 0) + r * r;
							}
						}
					}
					i = _r3.length;
					while (--i > -1) {
						_r3[i] = Math.sqrt(_r3[i]);
					}
				}
				i = props.length;
				while (--i > -1) {
					p = props[i];
					_calculateControlPoints(obj[p], curviness, quadratic, basic, _corProps[p]); //this method requires that _parseAnchors() and _setSegmentRatios() ran first so that _r1, _r2, and _r3 values are populated for all properties
				}
				return obj;
			}, 
			_parseBezierData = function(values, type, prepend) {
				type = type || "soft";
				var obj = {},
					inc = (type === "cubic") ? 3 : 2,
					soft = (type === "soft"),
					props = [],
					a, b, c, d, cur, i, j, l, p, cnt, tmp;
				if (soft && prepend) {
					values = [prepend].concat(values);
				}
				if (values == null || values.length < inc + 1) { throw "invalid Bezier data"; }
				for (p in values[0]) {
					props.push(p);
				}
				i = props.length;
				while (--i > -1) {
					p = props[i];
					obj[p] = cur = [];
					cnt = 0;
					l = values.length;
					for (j = 0; j < l; j++) {
						a = (prepend == null) ? values[j][p] : (typeof( (tmp = values[j][p]) ) === "string" && tmp.charAt(1) === "=") ? prepend[p] + Number(tmp.charAt(0) + tmp.substr(2)) : Number(tmp);
						if (soft) if (j > 1) if (j < l - 1) {
							cur[cnt++] = (a + cur[cnt-2]) / 2;
						}
						cur[cnt++] = a;
					}
					l = cnt - inc + 1;
					cnt = 0;
					for (j = 0; j < l; j += inc) {
						a = cur[j];
						b = cur[j+1];
						c = cur[j+2];
						d = (inc === 2) ? 0 : cur[j+3];
						cur[cnt++] = tmp = (inc === 3) ? new Segment(a, b, c, d) : new Segment(a, (2 * b + a) / 3, (2 * b + c) / 3, c);
					}
					cur.length = cnt;
				}
				return obj;
			},
			_parseAnchors = function(values, p, correlate, prepend) {
				var a = [],
					l, i, obj, p1, p2, p3, r1, tmp;
				if (prepend) {
					values = [prepend].concat(values);
					i = values.length;
					while (--i > -1) {
						if (typeof( (tmp = values[i][p]) ) === "string") if (tmp.charAt(1) === "=") {
							values[i][p] = prepend[p] + Number(tmp.charAt(0) + tmp.substr(2)); //accommodate relative values. Do it inline instead of breaking it out into a function for speed reasons
						}
					}
				}
				l = values.length - 2;
				if (l < 0) {
					a[0] = new Segment(values[0][p], 0, 0, values[(l < -1) ? 0 : 1][p]);
					return a;
				}
				for (i = 0; i < l; i++) {
					p1 = values[i][p];
					p2 = values[i+1][p];
					a[i] = new Segment(p1, 0, 0, p2);
					if (correlate) {
						p3 = values[i+2][p];
						_r1[i] = (_r1[i] || 0) + (p2 - p1) * (p2 - p1);
						_r2[i] = (_r2[i] || 0) + (p3 - p2) * (p3 - p2); 
					}
				}
				a[i] = new Segment(values[i][p], 0, 0, values[i+1][p]);
				return a;
			},
			_calculateControlPoints = function(a, curviness, quad, basic, correlate) {
				var l = a.length - 1,
					ii = 0,
					cp1 = a[0].a,
					i, p1, p2, p3, seg, m1, m2, mm, cp2, qb, r1, r2, tl;
				for (i = 0; i < l; i++) {
					seg = a[ii];
					p1 = seg.a;
					p2 = seg.d;
					p3 = a[ii+1].d;
					
					if (correlate) {
						r1 = _r1[i];
						r2 = _r2[i];
						tl = ((r2 + r1) * curviness * 0.25) / (basic ? 0.5 : _r3[i] || 0.5);
						m1 = p2 - (p2 - p1) * (basic ? curviness * 0.5 : tl / r1);
						m2 = p2 + (p3 - p2) * (basic ? curviness * 0.5 : tl / r2);
						mm = p2 - (m1 + (m2 - m1) * ((r1 * 3 / (r1 + r2)) + 0.5) / 4);
					} else {
						m1 = p2 - (p2 - p1) * curviness * 0.5;
						m2 = p2 + (p3 - p2) * curviness * 0.5;
						mm = p2 - (m1 + m2) / 2;
					}
					m1 += mm;
					m2 += mm;
					
					seg.c = cp2 = m1; 
					if (i != 0) {
						seg.b = cp1;
					} else {
						seg.b = cp1 = seg.a + (seg.c - seg.a) * 0.6; //instead of placing b on a exactly, we move it inline with c so that if the user specifies an ease like Back.easeIn or Elastic.easeIn which goes BEYOND the beginning, it will do so smoothly.
					}
					
					seg.da = p2 - p1;
					seg.ca = cp2 - p1;
					seg.ba = cp1 - p1;
					
					if (quad) {
						qb = cubicToQuadratic(p1, cp1, cp2, p2);
						a.splice(ii, 1, qb[0], qb[1], qb[2], qb[3]);
						ii += 4;
					} else {
						ii++;
					}
					
					cp1 = m2;
				}
				seg = a[ii];
				seg.b = cp1;
				seg.c = cp1 + (seg.d - cp1) * 0.4; //instead of placing c on d exactly, we move it inline with b so that if the user specifies an ease like Back.easeOut or Elastic.easeOut which goes BEYOND the end, it will do so smoothly.
				seg.da = seg.d - seg.a;
				seg.ca = seg.c - seg.a;
				seg.ba = cp1 - seg.a;
				if (quad) {
					qb = cubicToQuadratic(seg.a, cp1, seg.c, seg.d);
					a.splice(ii, 1, qb[0], qb[1], qb[2], qb[3]);
				}
			},
			cubicToQuadratic = BezierPlugin.cubicToQuadratic = function(a, b, c, d) {
				var q1 = {a:a},
					q2 = {},
					q3 = {},
					q4 = {c:d},
					mab = (a + b) / 2, 
					mbc = (b + c) / 2, 
					mcd = (c + d) / 2, 
					mabc = (mab + mbc) / 2,
					mbcd = (mbc + mcd) / 2,
					m8 = (mbcd - mabc) / 8;
				q1.b = mab + (a - mab) / 4;	
				q2.b = mabc + m8;
				q1.c = q2.a = (q1.b + q2.b) / 2;
				q2.c = q3.a = (mabc + mbcd) / 2;
				q3.b = mbcd - m8;
				q4.b = mcd + (d - mcd) / 4;
				q3.c = q4.a = (q3.b + q4.b) / 2;
				return [q1, q2, q3, q4];
			},
			quadraticToCubic = BezierPlugin.quadraticToCubic = function(a, b, c) {
				return new Segment(a, (2 * b + a) / 3, (2 * b + c) / 3, c);
			},
			_parseLengthData = function(obj, resolution) {
				resolution = resolution >> 0 || 6;
				var a = [],
					lengths = [],
					d = 0,
					total = 0,
					threshold = resolution - 1,
					segments = [],
					curLS = [], //current length segments array
					p, i, l, index;
				for (p in obj) {
					_addCubicLengths(obj[p], a, resolution);
				}
				l = a.length;
				for (i = 0; i < l; i++) {
					d += Math.sqrt(a[i]);
					index = i % resolution;
					curLS[index] = d;
					if (index === threshold) {
						total += d;
						index = (i / resolution) >> 0;
						segments[index] = curLS;
						lengths[index] = total;
						d = 0;
						curLS = [];
					}
				}
				return {length:total, lengths:lengths, segments:segments};
			},
			_addCubicLengths = function(a, steps, resolution) {
				var inc = 1 / resolution,
					j = a.length,
					d, d1, s, da, ca, ba, p, i, inv, bez, index;
				while (--j > -1) {
					bez = a[j];
					s = bez.a;
					da = bez.d - s;
					ca = bez.c - s;
					ba = bez.b - s;
					d = d1 = 0;
					for (i = 1; i <= resolution; i++) {
						p = inc * i;
						inv = 1 - p;
						d = d1 - (d1 = (p * p * da + 3 * inv * (p * ca + inv * ba)) * p);
						index = j * resolution + i - 1;
						steps[index] = (steps[index] || 0) + d * d;
					}
				}
			}; 
			
		
		p.constructor = BezierPlugin;
		BezierPlugin.API = 2;
		
		
		p._onInitTween = function(target, vars, tween) {
			this._target = target;
			if (vars instanceof Array) {
				vars = {values:vars};
			}
			this._props = [];
			this._timeRes = (vars.timeResolution == null) ? 6 : parseInt(vars.timeResolution);
			var values = vars.values || [],
				first = {},
				second = values[0],
				autoRotate = vars.autoRotate || tween.vars.orientToBezier,
				p, isFunc, i, j, prepend;
			
			this._autoRotate = autoRotate ? (autoRotate instanceof Array) ? autoRotate : [["x","y","rotation",((autoRotate === true) ? 0 : Number(autoRotate) || 0)]] : null;
			for (p in second) {
				this._props.push(p);
			}
			
			i = this._props.length;
			while (--i > -1) {
				p = this._props[i];
				this._overwriteProps.push(p);
				isFunc = this._func[p] = (typeof(target[p]) === "function");
				first[p] = (!isFunc) ? parseFloat(target[p]) : target[ ((p.indexOf("set") || typeof(target["get" + p.substr(3)]) !== "function") ? p : "get" + p.substr(3)) ]();
				if (!prepend) if (first[p] !== values[0][p]) {
					prepend = first;
				}
			}
			this._beziers = (vars.type !== "cubic" && vars.type !== "quadratic" && vars.type !== "soft") ? bezierThrough(values, isNaN(vars.curviness) ? 1 : vars.curviness, false, (vars.type === "thruBasic"), vars.correlate, prepend) : _parseBezierData(values, vars.type, first);
			this._segCount = this._beziers[p].length;
			
			if (this._timeRes) {
				var ld = _parseLengthData(this._beziers, this._timeRes);
				this._length = ld.length;
				this._lengths = ld.lengths;
				this._segments = ld.segments;
				this._l1 = this._li = this._s1 = this._si = 0;
				this._l2 = this._lengths[0];
				this._curSeg = this._segments[0];
				this._s2 = this._curSeg[0];
				this._prec = 1 / this._curSeg.length;
			}
			
			if ((autoRotate = this._autoRotate)) {
				if (!(autoRotate[0] instanceof Array)) {
					this._autoRotate = autoRotate = [autoRotate];
				}
				i = autoRotate.length;
				while (--i > -1) {
					for (j = 0; j < 3; j++) {
						p = autoRotate[i][j];
						this._func[p] = (typeof(target[p]) === "function") ? target[ ((p.indexOf("set") || typeof(target["get" + p.substr(3)]) !== "function") ? p : "get" + p.substr(3)) ] : false;
					}
				}
			}
			return true;
		}
		
		//gets called every time the tween updates, passing the new ratio (typically a value between 0 and 1, but not always (for example, if an Elastic.easeOut is used, the value can jump above 1 mid-tween). It will always start and 0 and end at 1.
		p.setRatio = function(v) {
			var segments = this._segCount,
				func = this._func,
				target = this._target,
				curIndex, inv, i, p, b, t, val, l, lengths, curSeg;
			if (!this._timeRes) {
				curIndex = (v < 0) ? 0 : (v >= 1) ? segments - 1 : (segments * v) >> 0;
				t = (v - (curIndex * (1 / segments))) * segments;
			} else {
				lengths = this._lengths;
				curSeg = this._curSeg;
				v *= this._length;
				i = this._li;
				//find the appropriate segment (if the currently cached one isn't correct)
				if (v > this._l2 && i < segments - 1) {
					l = segments - 1;
					while (i < l && (this._l2 = lengths[++i]) <= v) {	}
					this._l1 = lengths[i-1];
					this._li = i;
					this._curSeg = curSeg = this._segments[i];
					this._s2 = curSeg[(this._s1 = this._si = 0)];
				} else if (v < this._l1 && i > 0) {
					while (i > 0 && (this._l1 = lengths[--i]) >= v) { 	}
					if (i === 0 && v < this._l1) {
						this._l1 = 0;
					} else {
						i++;
					}
					this._l2 = lengths[i];
					this._li = i;
					this._curSeg = curSeg = this._segments[i];
					this._s1 = curSeg[(this._si = curSeg.length - 1) - 1] || 0;
					this._s2 = curSeg[this._si];
				}
				curIndex = i;
				//now find the appropriate sub-segment (we split it into the number of pieces that was defined by "precision" and measured each one)
				v -= this._l1;
				i = this._si;
				if (v > this._s2 && i < curSeg.length - 1) {
					l = curSeg.length - 1;
					while (i < l && (this._s2 = curSeg[++i]) <= v) {	}
					this._s1 = curSeg[i-1];
					this._si = i;
				} else if (v < this._s1 && i > 0) {
					while (i > 0 && (this._s1 = curSeg[--i]) >= v) {	}
					if (i === 0 && v < this._s1) {
						this._s1 = 0;
					} else {
						i++;
					}
					this._s2 = curSeg[i];
					this._si = i;
				}
				t = (i + (v - this._s1) / (this._s2 - this._s1)) * this._prec;
			}
			inv = 1 - t;
			
			i = this._props.length;
			while (--i > -1) {
				p = this._props[i];
				b = this._beziers[p][curIndex];
				val = (t * t * b.da + 3 * inv * (t * b.ca + inv * b.ba)) * t + b.a;
				if (this._round[p]) {
					val = (val + ((val > 0) ? 0.5 : -0.5)) >> 0;
				}
				if (func[p]) {
					target[p](val);
				} else {
					target[p] = val;
				}
			}
			
			if (this._autoRotate) {
				var ar = this._autoRotate,
					b2, x1, y1, x2, y2, add, conv;
				i = ar.length;
				while (--i > -1) {
					p = ar[i][2];
					add = ar[i][3] || 0;
					conv = (ar[i][4] == true) ? 1 : _RAD2DEG;
					b = this._beziers[ar[i][0]][curIndex];
					b2 = this._beziers[ar[i][1]][curIndex];
					
					x1 = b.a + (b.b - b.a) * t;
					x2 = b.b + (b.c - b.b) * t;
					x1 += (x2 - x1) * t;
					x2 += ((b.c + (b.d - b.c) * t) - x2) * t;
					
					y1 = b2.a + (b2.b - b2.a) * t;
					y2 = b2.b + (b2.c - b2.b) * t;
					y1 += (y2 - y1) * t;
					y2 += ((b2.c + (b2.d - b2.c) * t) - y2) * t;
					
					val = Math.atan2(y2 - y1, x2 - x1) * conv + add;
					
					if (func[p]) {
						func[p].call(target, val);
					} else {
						target[p] = val;
					}
				}
			}
		}
		
		p._roundProps = function(lookup, value) {
			var op = this._overwriteProps,
				i = op.length;
			while (--i > -1) {
				if (lookup[op[i]] || lookup.bezier || lookup.bezierThrough) {
					this._round[op[i]] = value;
				}
			}
		}
		
		p._kill = function(lookup) {
			var a = this._props, 
				p, i;
			for (p in _beziers) {
				if (p in lookup) {
					delete this._beziers[p];
					delete this._func[p];
					i = a.length;
					while (--i > -1) {
						if (a[i] === p) {
							a.splice(i, 1);
						}
					}
				}
			}
			return TweenPlugin.prototype._kill.call(this, lookup);
		}
		
		TweenPlugin.activate([BezierPlugin]);
		return BezierPlugin;
		
	}, true);

}); if (window._gsDefine) { _gsQueue.pop()(); }