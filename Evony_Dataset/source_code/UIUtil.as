// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//com.evony.util.UIUtil

package com.evony.util
{
    import mx.effects.Blur;
    import flash.net.URLLoader;
    import flash.net.URLRequest;
    import flash.events.IOErrorEvent;
    import flash.events.Event;
    import com.evony.Context;
    import com.evony.common.beans.BuildingBean;
    import com.evony.common.constants.BuildingConstants;
    import flash.utils.ByteArray;
    import com.evony.common.beans.ItemBean;
    import com.evony.eum.ItemEumDefine;
    import mx.core.IFlexDisplayObject;
    import flash.display.MovieClip;
    import flash.geom.Point;
    import mx.core.Application;
    import mx.core.UIComponent;
    import flash.utils.Timer;
    import view.MainWin;
    import com.evony.Lang;
    import mx.events.TweenEvent;
    import mx.managers.PopUpManager;
    import com.evony.common.beans.CastleResourceBean;
    import com.evony.common.beans.ConditionBean;
    import mx.controls.dataGridClasses.DataGridColumn;
    import com.evony.common.constants.CommonConstants;
    import mx.core.IUIComponent;
    import mx.managers.ISystemManager;
    import flash.system.Capabilities;
    import flash.display.DisplayObject;
    import com.evony.common.beans.BuildingQueueBean;
    import flash.display.DisplayObjectContainer;
    import com.evony.common.beans.ConditionDependBuildingBean;
    import com.evony.common.beans.ConditionDependItemBean;
    import com.evony.common.beans.ConditionDependTechBean;
    import flash.display.*;
    import flash.events.*;
    import flash.utils.*;
    import flash.net.*;

    public class UIUtil 
    {

        private static var mShowEffect:Blur = new Blur();
        private static var mHideEffect:Blur = new Blur();


        public static function loadFile(url:String, callback:Function, fault:Function=null):void
        {
            var ioErrorHandler:Function;
            var onConfigLoadComplete:Function;
            var loader:URLLoader;
            var request:URLRequest;
            ioErrorHandler = function (_arg_1:IOErrorEvent):void
            {
                if (fault != null)
                {
                    fault.apply();
                };
                trace(("Unable to load url=" + url));
            };
            onConfigLoadComplete = function (_arg_1:Event):void
            {
                var _local_2:URLLoader = URLLoader(_arg_1.target);
                callback.apply(null, [_local_2.data]);
            };
            try
            {
                loader = new URLLoader();
                loader.addEventListener(Event.COMPLETE, onConfigLoadComplete);
                loader.addEventListener(IOErrorEvent.IO_ERROR, ioErrorHandler);
                request = new URLRequest(url);
                loader.load(request);
            }
            catch(error:Error)
            {
                if (fault != null)
                {
                    fault.apply();
                };
                trace(("Unable to load url=" + url));
            };
        }

        public static function judgeTime():int
        {
            var _local_1:Number = new Date().valueOf();
            var _local_2:Number = Context.getInstance().getPlayerBean().playerInfo.createrTime;
            var _local_3:Number = Context.getInstance().getTimeDiff();
            return (int((((((_local_1 - _local_2) + _local_3) / 1000) / 3600) / 24)));
        }

        public static function GetTavernLevel():int
        {
            var _local_2:int;
            var _local_3:BuildingBean;
            var _local_1:int;
            while (_local_1 < Context.getInstance().getPlayerBean().castlesArray.length)
            {
                _local_2 = 0;
                while (_local_2 < Context.getInstance().getPlayerBean().getCastles(_local_1).buildingsArray.length)
                {
                    _local_3 = Context.getInstance().getPlayerBean().getCastles(_local_1).getBuildings(_local_2);
                    if (_local_3.typeId == BuildingConstants.TYPE_TAVERN)
                    {
                        return (_local_3.level);
                    };
                    _local_2++;
                };
                _local_1++;
            };
            return (0);
        }

        public static function DecryptUrl(_arg_1:String):String
        {
            var _local_2:int;
            var _local_3:int;
            var _local_6:int;
            var _local_4:* = "";
            var _local_5:ByteArray = new ByteArray();
            while (_local_6 < (_arg_1.length / 2))
            {
                if (((_arg_1.charAt((2 * _local_6)) == "#") || (_arg_1.charAt((2 * _local_6)) == "&"))) break;
                if (((_arg_1.charAt((2 * _local_6)) >= "0") && (_arg_1.charAt((2 * _local_6)) <= "9")))
                {
                    _local_2 = Number(_arg_1.substr((2 * _local_6), 1));
                }
                else
                {
                    if (((_arg_1.charAt((2 * _local_6)) == "a") || (_arg_1.charAt((2 * _local_6)) == "A")))
                    {
                        _local_2 = 10;
                    }
                    else
                    {
                        if (((_arg_1.charAt((2 * _local_6)) == "b") || (_arg_1.charAt((2 * _local_6)) == "B")))
                        {
                            _local_2 = 11;
                        }
                        else
                        {
                            if (((_arg_1.charAt((2 * _local_6)) == "c") || (_arg_1.charAt((2 * _local_6)) == "C")))
                            {
                                _local_2 = 12;
                            }
                            else
                            {
                                if (((_arg_1.charAt((2 * _local_6)) == "d") || (_arg_1.charAt((2 * _local_6)) == "D")))
                                {
                                    _local_2 = 13;
                                }
                                else
                                {
                                    if (((_arg_1.charAt((2 * _local_6)) == "e") || (_arg_1.charAt((2 * _local_6)) == "E")))
                                    {
                                        _local_2 = 14;
                                    }
                                    else
                                    {
                                        if (((_arg_1.charAt((2 * _local_6)) == "f") || (_arg_1.charAt((2 * _local_6)) == "F")))
                                        {
                                            _local_2 = 15;
                                        };
                                    };
                                };
                            };
                        };
                    };
                };
                if (((_arg_1.charAt(((2 * _local_6) + 1)) >= "0") && (_arg_1.charAt(((2 * _local_6) + 1)) <= "9")))
                {
                    _local_3 = Number(_arg_1.substr(((2 * _local_6) + 1), 1));
                }
                else
                {
                    if (((_arg_1.charAt(((2 * _local_6) + 1)) == "a") || (_arg_1.charAt(((2 * _local_6) + 1)) == "A")))
                    {
                        _local_3 = 10;
                    }
                    else
                    {
                        if (((_arg_1.charAt(((2 * _local_6) + 1)) == "b") || (_arg_1.charAt(((2 * _local_6) + 1)) == "B")))
                        {
                            _local_3 = 11;
                        }
                        else
                        {
                            if (((_arg_1.charAt(((2 * _local_6) + 1)) == "c") || (_arg_1.charAt(((2 * _local_6) + 1)) == "C")))
                            {
                                _local_3 = 12;
                            }
                            else
                            {
                                if (((_arg_1.charAt(((2 * _local_6) + 1)) == "d") || (_arg_1.charAt(((2 * _local_6) + 1)) == "D")))
                                {
                                    _local_3 = 13;
                                }
                                else
                                {
                                    if (((_arg_1.charAt(((2 * _local_6) + 1)) == "e") || (_arg_1.charAt(((2 * _local_6) + 1)) == "E")))
                                    {
                                        _local_3 = 14;
                                    }
                                    else
                                    {
                                        if (((_arg_1.charAt(((2 * _local_6) + 1)) == "f") || (_arg_1.charAt(((2 * _local_6) + 1)) == "F")))
                                        {
                                            _local_3 = 15;
                                        };
                                    };
                                };
                            };
                        };
                    };
                };
                _local_5[_local_6] = ((_local_2 * 16) + _local_3);
                _local_6++;
            };
            _local_4 = _local_5.toString();
            trace(_local_4);
            return (_local_4);
        }

        public static function checkItem(_arg_1:String, _arg_2:int):Boolean
        {
            var _local_5:ItemBean;
            var _local_3:Boolean;
            var _local_4:int;
            while (_local_4 < Context.getInstance().getPlayerBean().itemsArray.length)
            {
                _local_5 = Context.getInstance().getPlayerBean().getItems(_local_4);
                if (((_local_5.id == _arg_1) && (_local_5.count >= _arg_2)))
                {
                    _local_3 = true;
                    break;
                };
                _local_4++;
            };
            if (_local_3 == false)
            {
                if (Context.getInstance().getPlayerBean().playerInfo.medal >= (ItemEumDefine.getItemEum(_arg_1).price * _arg_2))
                {
                    _local_3 = true;
                };
            };
            return (_local_3);
        }

        public static function setPopopHelpWindowStye2(_arg_1:IFlexDisplayObject):void
        {
        }

        public static function doStopAtFirstFrame(_arg_1:MovieClip, _arg_2:int):int
        {
            _arg_1.gotoAndStop(1);
            return (_arg_2);
        }

        public static function checkItemAmulet():String
        {
            var _local_3:ItemBean;
            var _local_1:Boolean;
            var _local_2:int;
            while (_local_2 < Context.getInstance().getPlayerBean().itemsArray.length)
            {
                _local_3 = Context.getInstance().getPlayerBean().getItems(_local_2);
                if (((isAmulet(_local_3.id)) && (_local_3.count >= 1)))
                {
                    return (_local_3.id);
                };
                _local_2++;
            };
            if (Context.getInstance().getPlayerBean().playerInfo.medal >= ItemEumDefine.getItemEum("player.box.gambling.1").price)
            {
                return ("player.box.gambling.3");
            };
            return (null);
        }

        public static function checkItemEx(_arg_1:String, _arg_2:int):Boolean
        {
            var _local_5:ItemBean;
            var _local_3:Boolean;
            var _local_4:int;
            while (_local_4 < Context.getInstance().getPlayerBean().itemsArray.length)
            {
                _local_5 = Context.getInstance().getPlayerBean().getItems(_local_4);
                if (((_local_5.id == _arg_1) && (_local_5.count >= _arg_2)))
                {
                    _local_3 = true;
                    break;
                };
                _local_4++;
            };
            return (_local_3);
        }

        public static function getRemainTime(_arg_1:int):String
        {
            var _local_2:int = Context.getInstance().getTimeDiff();
            var _local_3:Number = ((new Date().valueOf() - _local_2) / 1000);
            var _local_4:Number = ((_arg_1 - _local_3) + 1);
            return (timeToString(_local_4));
        }

        public static function getCenterPointOfUI():Point
        {
            var _local_1:Point = new Point();
            _local_1.x = ((getBottomRightPoint().x + getTopLeftPoint().x) / 2);
            _local_1.y = ((getBottomRightPoint().y + getTopLeftPoint().y) / 2);
            return (_local_1);
        }

        public static function isUIComponentVisible(_arg_1:UIComponent, _arg_2:Timer=null):Boolean
        {
            if (!_arg_1.initialized)
            {
                return (_arg_1.visible);
            };
            if (((!(_arg_2 == null)) && (_arg_2.currentCount < 20)))
            {
                return (true);
            };
            var _local_3:* = (!(_arg_1.parent == null));
            var _local_4:Object = _arg_1;
            while (_local_4 != Application.application)
            {
                if (!_local_4.visible)
                {
                    _local_3 = false;
                    break;
                };
                if (_local_4.parent)
                {
                    _local_4 = _local_4.parent;
                }
                else
                {
                    break;
                };
            };
            if (((!(_arg_2 == null)) && (!(_local_3))))
            {
                trace((_arg_1.className + " 被隐藏了. timer stop"));
                _arg_2.stop();
                _arg_2.reset();
            };
            return (_local_3);
        }

        public static function getBottomRightPoint():Point
        {
            var _local_1:Number;
            var _local_2:Number;
            if ((((MainWin.instance == null) || (MainWin.instance.RB == null)) || (MainWin.instance.rightTopBg == null)))
            {
                return (new Point(0, 0));
            };
            _local_1 = MainWin.instance.rightTopBg.x;
            _local_2 = (MainWin.instance.RB.y + 50);
            return (new Point(_local_1, _local_2));
        }

        public static function getCenterViewWidth():Number
        {
            return (getBottomRightPoint().x - getTopLeftPoint().x);
        }

        public static function getFinishDate(_arg_1:int):String
        {
            var _local_2:Date = new Date((_arg_1 * 1000));
            var _local_3:Number = _local_2.getUTCDate();
            var _local_4:Number = _local_2.getUTCMonth();
            var _local_5:Number = _local_2.getUTCHours();
            var _local_6:Number = _local_2.getUTCMinutes();
            var _local_7:Number = _local_2.getUTCSeconds();
            var _local_8:Number = _local_2.getUTCMilliseconds();
            var _local_9:String = new String();
            if ((_local_4 + 1) < 10)
            {
                _local_9 = (_local_9 + "0");
            };
            _local_9 = (_local_9 + (_local_4 + 1));
            _local_9 = (_local_9 + "/");
            if (_local_3 < 10)
            {
                _local_9 = (_local_9 + "0");
            };
            _local_9 = (_local_9 + _local_3);
            _local_9 = (_local_9 + " ");
            if (_local_5 < 10)
            {
                _local_9 = (_local_9 + "0");
            };
            _local_9 = (_local_9 + _local_5);
            _local_9 = (_local_9 + ":");
            if (_local_6 < 10)
            {
                _local_9 = (_local_9 + "0");
            };
            _local_9 = (_local_9 + _local_6);
            _local_9 = (_local_9 + ":");
            if (_local_7 < 10)
            {
                _local_9 = (_local_9 + "0");
            };
            _local_9 = (_local_9 + _local_7);
            return (_local_9);
        }

        public static function FormatInt(_arg_1:Number):String
        {
            _arg_1 = Math.floor(_arg_1);
            var _local_2:String = _arg_1.toString();
            var _local_3:int;
            var _local_4:* = "";
            if (_arg_1 < 0)
            {
                _local_2 = _local_2.substr(1);
            };
            if (_local_2.length <= 3)
            {
                _local_4 = _local_2;
            }
            else
            {
                _local_4 = _local_2.substr((_local_2.length - 3), 3);
                _local_3 = (_local_2.length - 3);
                while (_local_3 > 0)
                {
                    if (_local_3 < 3)
                    {
                        _local_4 = ((_local_2.substring(0, _local_3) + ",") + _local_4);
                        break;
                    };
                    _local_4 = ((_local_2.substr((_local_3 - 3), 3) + ",") + _local_4);
                    _local_3 = (_local_3 - 3);
                };
            };
            if (_arg_1 < 0)
            {
                _local_4 = ("-" + _local_4);
            };
            return (_local_4);
        }

        public static function timeToString(_arg_1:int):String
        {
            var _local_2:* = "";
            var _local_3:int = int((_arg_1 / (60 * 60)));
            if (_local_3 > 0)
            {
                _local_2 = (_local_2 + ((_local_3 + Lang.msg("时")) + " "));
            };
            var _local_4:int = int(((_arg_1 / 60) % 60));
            if (((_local_2.length > 0) || (_local_4 > 0)))
            {
                _local_2 = (_local_2 + ((_local_4 + Lang.msg("分")) + " "));
            };
            var _local_5:int = (_arg_1 % 60);
            if (_local_5 < 10)
            {
                _local_2 = (_local_2 + "0");
            };
            return (_local_2 + (_local_5 + Lang.msg("秒")));
        }

        public static function isBuildingDestroy(_arg_1:BuildingBean):Boolean
        {
            return ((_arg_1.status == BuildingConstants.STATUS_NORMAL) && (_arg_1.level == 0));
        }

        public static function hidePopupEffect(control:IFlexDisplayObject):void
        {
            mHideEffect.stop();
            mHideEffect.blurXFrom = 0;
            mHideEffect.blurYFrom = 0;
            mHideEffect.blurXTo = 0xFF;
            mHideEffect.blurYTo = 0xFF;
            mHideEffect.addEventListener(TweenEvent.TWEEN_END, function ():void
            {
                PopUpManager.removePopUp(control);
            });
            mHideEffect.duration = 300;
            mHideEffect.target = control;
            mHideEffect.play();
        }

        public static function getCenterViewHeight():Number
        {
            return (getBottomRightPoint().y - getTopLeftPoint().y);
        }

        public static function doPlay(_arg_1:MovieClip, _arg_2:int):int
        {
            _arg_1.play();
            return (_arg_2);
        }

        public static function isInnerBuilding(_arg_1:int):Boolean
        {
            return (_arg_1 < BuildingConstants.OUTSIDE_BUILDING_ADDITION);
        }

        public static function isResourceConditionMatch(_arg_1:ConditionBean):Boolean
        {
            var _local_2:CastleResourceBean = Context.getInstance().getCurCastle().resource;
            if (((_arg_1.gold > _local_2.gold) && (_arg_1.gold > 0)))
            {
                return (false);
            };
            if (((_arg_1.food > _local_2.food.amount) && (_arg_1.food > 0)))
            {
                return (false);
            };
            if (((_arg_1.wood > _local_2.wood.amount) && (_arg_1.wood > 0)))
            {
                return (false);
            };
            if (((_arg_1.iron > _local_2.iron.amount) && (_arg_1.iron > 0)))
            {
                return (false);
            };
            if (((_arg_1.stone > _local_2.stone.amount) && (_arg_1.stone > 0)))
            {
                return (false);
            };
            return (true);
        }

        public static function getItemBeanFromPlayer(_arg_1:String):ItemBean
        {
            var _local_3:ItemBean;
            var _local_2:ItemBean;
            for each (_local_3 in Context.getInstance().getPlayerBean().itemsArray)
            {
                if (_local_3.id == _arg_1)
                {
                    _local_2 = _local_3;
                };
            };
            return (_local_2);
        }

        public static function FormatTwoString(_arg_1:uint):String
        {
            var _local_2:String = ("0" + _arg_1.toString());
            return (_local_2.substr((_local_2.length - 2), 2));
        }

        public static function myLabelFunction(_arg_1:Object, _arg_2:DataGridColumn):String
        {
            if (_arg_2.dataField == "prestige")
            {
                return (FormatInt(_arg_1.prestige));
            };
            if (_arg_2.dataField == "honor")
            {
                return (FormatInt(_arg_1.honor));
            };
            return ("0");
        }

        public static function getTopLeftPoint():Point
        {
            var _local_1:Number;
            var _local_2:Number;
            if ((((MainWin.instance == null) || (MainWin.instance.Lborder == null)) || (MainWin.instance.Tborder2 == null)))
            {
                return (new Point(0, 0));
            };
            _local_1 = 0;
            _local_2 = ((MainWin.instance.Tborder2.y + MainWin.instance.Tborder2.height) - 3);
            return (new Point(_local_1, _local_2));
        }

        public static function checkOffice():Boolean
        {
            var _local_2:int;
            var _local_3:int;
            var _local_4:BuildingBean;
            var _local_1:Boolean;
            if ((judgeTimeBeginner() - CommonConstants.FRESH_PLAYER_DAY_MAX) >= 0)
            {
                _local_1 = true;
            }
            else
            {
                _local_2 = 0;
                while (_local_2 < Context.getInstance().getPlayerBean().castlesArray.length)
                {
                    _local_3 = 0;
                    while (_local_3 < Context.getInstance().getPlayerBean().getCastles(_local_2).buildingsArray.length)
                    {
                        _local_4 = Context.getInstance().getPlayerBean().getCastles(_local_2).getBuildings(_local_3);
                        if (((_local_4.typeId == BuildingConstants.TYPE_TOWN_HALL) && (_local_4.level > 4)))
                        {
                            _local_1 = true;
                            break;
                        };
                        _local_3++;
                    };
                    _local_2++;
                };
            };
            return (_local_1);
        }

        private static function doCenterPopUp(_arg_1:IFlexDisplayObject):void
        {
            if (_arg_1)
            {
                if ((Application.application.width - _arg_1.width) > 0)
                {
                    _arg_1.x = (((Application.application.width - _arg_1.width) / 2) - 150);
                    _arg_1.y = (((Application.application.height - _arg_1.height) / 2) - 30);
                    if (((_arg_1.x < 0) || (_arg_1.y < 0)))
                    {
                        _arg_1.x = ((Application.application.width - _arg_1.width) / 2);
                        _arg_1.y = ((Application.application.height - _arg_1.height) / 2);
                    };
                    PopUpManager.bringToFront(_arg_1);
                }
                else
                {
                    PopUpManager.centerPopUp(_arg_1);
                };
            };
        }

        public static function doStop(_arg_1:MovieClip, _arg_2:int):int
        {
            _arg_1.stop();
            return (_arg_2);
        }

        public static function setPopopHelpWindowStye(_arg_1:IFlexDisplayObject):void
        {
            var _local_2:ISystemManager = IUIComponent(_arg_1).systemManager;
            if (_local_2 != null)
            {
                _local_2.screen.x = 0;
                _local_2.screen.y = 0;
                _local_2.screen.width = Capabilities.screenResolutionX;
                _local_2.screen.height = Capabilities.screenResolutionY;
            };
        }

        public static function showPopupEffect(_arg_1:IFlexDisplayObject, _arg_2:DisplayObject, _arg_3:Boolean=false):void
        {
        }

        public static function buildingQueueBean2BuildingBean(_arg_1:BuildingQueueBean):BuildingBean
        {
            if (_arg_1 == null)
            {
                return (null);
            };
            var _local_2:BuildingBean = new BuildingBean();
            _local_2.endTime = _arg_1.costTime;
            _local_2.level = 1;
            _local_2.name = _arg_1.name;
            _local_2.positionId = _arg_1.positionId;
            _local_2.startTime = 0;
            _local_2.status = BuildingConstants.STATUS_WAITING;
            _local_2.typeId = _arg_1.typeId;
            return (_local_2);
        }

        public static function goThroughSprite(_arg_1:*, _arg_2:int, _arg_3:Function):int
        {
            if ((_arg_1 is MovieClip))
            {
                _arg_2 = _arg_3(MovieClip(_arg_1), _arg_2);
            };
            var _local_4:int;
            while (_local_4 < _arg_1.numChildren)
            {
                if ((_arg_1.getChildAt(_local_4) is DisplayObjectContainer))
                {
                    _arg_2 = goThroughSprite(DisplayObjectContainer(_arg_1.getChildAt(_local_4)), _arg_2, _arg_3);
                };
                if ((_arg_1.getChildAt(_local_4) is MovieClip))
                {
                    _arg_2 = _arg_3(MovieClip(MovieClip(_arg_1.getChildAt(_local_4))), _arg_2);
                };
                _local_4++;
            };
            return (_arg_2);
        }

        public static function isConditionMatch(_arg_1:ConditionBean):Boolean
        {
            var _local_2:ConditionDependBuildingBean;
            var _local_3:ConditionDependItemBean;
            var _local_4:ConditionDependTechBean;
            if (_arg_1.buildingsArray != null)
            {
                for each (_local_2 in _arg_1.buildingsArray)
                {
                    if (!_local_2.successFlag)
                    {
                        return (false);
                    };
                };
            };
            if (_arg_1.itemsArray != null)
            {
                for each (_local_3 in _arg_1.itemsArray)
                {
                    if (!_local_3.successFlag)
                    {
                        return (false);
                    };
                };
            };
            if (_arg_1.techsArray != null)
            {
                for each (_local_4 in _arg_1.techsArray)
                {
                    if (!_local_4.successFlag)
                    {
                        return (false);
                    };
                };
            };
            return (true);
        }

        public static function doPlayFromFirstFrame(_arg_1:MovieClip, _arg_2:int):int
        {
            _arg_1.gotoAndPlay(1);
            return (_arg_2);
        }

        public static function isAmulet(_arg_1:String):Boolean
        {
            if (((((((((((((_arg_1 == "player.box.gambling.1") || (_arg_1 == "player.box.gambling.2")) || (_arg_1 == "player.box.gambling.3")) || (_arg_1 == "player.box.gambling.4")) || (_arg_1 == "player.box.gambling.5")) || (_arg_1 == "player.box.gambling.6")) || (_arg_1 == "player.box.gambling.7")) || (_arg_1 == "player.box.gambling.8")) || (_arg_1 == "player.box.gambling.9")) || (_arg_1 == "player.box.gambling.10")) || (_arg_1 == "player.box.gambling.11")) || (_arg_1 == "player.box.gambling.12")))
            {
                return (true);
            };
            return (false);
        }

        public static function judgeTimeBeginner():int
        {
            var _local_1:Number = new Date(Context.getInstance().serverYear, (Context.getInstance().serverMonth - 1), Context.getInstance().serverDate, Context.getInstance().serverHours, Context.getInstance().serverMinutes, 0).valueOf();
            var _local_2:Number = Context.getInstance().getPlayerBean().playerInfo.createrTime;
            var _local_3:Number = Context.getInstance().getTimeDiff();
            var _local_4:int = int(int((((((_local_1 - _local_2) + _local_3) / 1000) / 3600) / 24)));
            return (_local_4);
        }


    }
}//package com.evony.util

