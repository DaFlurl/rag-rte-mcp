// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//view.castle.world.WorldMap

package view.castle.world
{
    import mx.core.UIComponent;
    import flash.display.BitmapData;
    import com.evony.util.EvonyAnimation;
    import flash.geom.Point;
    import flash.geom.Rectangle;
    import com.evony.util.EvonyImage;
    import flash.display.Sprite;
    import com.evony.common.beans.CastleBean;
    import com.evony.common.beans.FieldBean;
    import com.evony.Coordinate;
    import com.evony.Context;
    import mx.collections.ArrayCollection;
    import flash.events.MouseEvent;
    import com.evony.common.beans.MapCastleBean;
    import com.evony.common.module.common.MapInfoSimpleResponse;
    import com.evony.util.UIUtil;
    import view.castle.Map;
    import flash.net.SharedObject;
    import com.evony.common.constants.FieldConstants;
    import com.evony.common.constants.DeclaredWarConstants;
    import com.evony.events.CastleFlagEvent;
    import flash.display.Bitmap;
    import flash.events.Event;
    import com.evony.events.MapResetPointEvent;
    import mx.managers.PopUpManager;
    import com.evony.client.action.ActionFactory;
    import mx.managers.CursorManager;
    import com.evony.client.response.ResponseDispatcher;
    import com.evony.MsgDispacther;
    import view.module.trainningField.NewArmyWin;
    import flash.utils.*;

    public class WorldMap extends UIComponent 
    {

        public static const TILE_WIDTH:int = 120;
        public static const TILE_HEIGHT:int = 75;
        public static const mapOne_w:int = 7;
        public static const mapOne_h:int = 7;

        private var fieldMap:Object;
        private var restY:int = 0;
        private var restX:int = 0;
        public var center_x:int;
        public var center_y:int;
        private var appWidth:int = 0;
        private var tilePic:BitmapData;
        public var playing_list:Object = null;
        private var oldCenter_x:int;
        private var oldCenter_y:int;
        private var selectedCirle:EvonyAnimation;
        private var mapNine_size:int;
        private var isDrag:Boolean = false;
        private var lastMouseX:int = 0;
        private var lastMouseY:int = 0;
        private var mapNine_h:int;
        private var groundMaxX:int = 7;
        private var groundMaxY:int = 7;
        private var mapNine_w:int;
        private var oldTileMap:Object;
        private var appHeight:int = 0;
        private var lastRequestCenter:Point = null;
        private var oldGroundMap:Object;
        private var curClickTile:Tile;

        private var appRect:Rectangle = new Rectangle();
        private var tileMap:UIComponent = new UIComponent();
        private var tileArray:Array = new Array();
        private var groundArray:Array = new Array();
        private var mstart:Point = new Point();
        private var mfin:Point = new Point();
        private var cityPos:Point = new Point();
        private var worldMapTooltip:WorldMapToolTip = new WorldMapToolTip();
        private var distancePoint:Point = new Point(0, 0);
        public var bkimg:EvonyImage = new EvonyImage();
        private var debugWin:Sprite = new Sprite();

        public function WorldMap()
        {
            setMapSize();
            super();
        }

        public static function divideRectangleByMax(_arg_1:Rectangle, _arg_2:int, _arg_3:int):Array
        {
            var _local_4:Array = new Array();
            var _local_5:Rectangle = new Rectangle();
            var _local_6:Rectangle = new Rectangle();
            var _local_7:Rectangle = new Rectangle();
            var _local_8:Rectangle = new Rectangle();
            _arg_1.x = (_arg_1.x % _arg_2);
            _arg_1.y = (_arg_1.y % _arg_3);
            if (((_arg_1.right > _arg_2) && (_arg_1.bottom > _arg_3)))
            {
                _local_5.x = _arg_1.x;
                _local_5.y = _arg_1.y;
                _local_5.width = (_arg_2 - _arg_1.x);
                _local_5.height = (_arg_3 - _arg_1.y);
                if (!_local_5.isEmpty())
                {
                    _local_4.push(_local_5);
                };
                _local_6.x = 0;
                _local_6.y = _arg_1.y;
                _local_6.width = (_arg_1.width - (_arg_2 - _arg_1.x));
                _local_6.height = (_arg_3 - _arg_1.y);
                if (!_local_6.isEmpty())
                {
                    _local_4.push(_local_6);
                };
                _local_7.x = _arg_1.x;
                _local_7.y = 0;
                _local_7.width = (_arg_2 - _arg_1.x);
                _local_7.height = (_arg_1.height - (_arg_3 - _arg_1.y));
                if (!_local_7.isEmpty())
                {
                    _local_4.push(_local_7);
                };
                _local_8.x = 0;
                _local_8.y = 0;
                _local_8.width = (_arg_1.width - (_arg_2 - _arg_1.x));
                _local_8.height = (_arg_1.height - (_arg_3 - _arg_1.y));
                if (!_local_8.isEmpty())
                {
                    _local_4.push(_local_8);
                };
            }
            else
            {
                if (((_arg_1.right > _arg_2) && (_arg_1.bottom <= _arg_3)))
                {
                    _local_5.x = _arg_1.x;
                    _local_5.y = _arg_1.y;
                    _local_5.width = (_arg_2 - _arg_1.x);
                    _local_5.height = _arg_1.height;
                    if (!_local_5.isEmpty())
                    {
                        _local_4.push(_local_5);
                    };
                    _local_6.x = 0;
                    _local_6.y = _arg_1.y;
                    _local_6.width = (_arg_1.width - (_arg_2 - _arg_1.x));
                    _local_6.height = _arg_1.height;
                    if (!_local_6.isEmpty())
                    {
                        _local_4.push(_local_6);
                    };
                }
                else
                {
                    if (((_arg_1.right <= _arg_2) && (_arg_1.bottom > _arg_3)))
                    {
                        _local_5.x = _arg_1.x;
                        _local_5.y = _arg_1.y;
                        _local_5.width = _arg_1.width;
                        _local_5.height = (_arg_3 - _arg_1.y);
                        if (!_local_5.isEmpty())
                        {
                            _local_4.push(_local_5);
                        };
                        _local_6.x = _arg_1.x;
                        _local_6.y = 0;
                        _local_6.width = _arg_1.width;
                        _local_6.height = (_arg_1.height - (_arg_3 - _arg_1.y));
                        if (!_local_6.isEmpty())
                        {
                            _local_4.push(_local_6);
                        };
                    }
                    else
                    {
                        _local_4.push(_arg_1);
                    };
                };
            };
            return (_local_4);
        }


        private function refreshMyFieldMap():void
        {
            var _local_3:CastleBean;
            var _local_4:int;
            var _local_5:FieldBean;
            var _local_6:Coordinate;
            this.fieldMap = new Object();
            var _local_1:ArrayCollection = Context.getInstance().getPlayerBean().castlesArray;
            var _local_2:int;
            while (_local_2 < _local_1.length)
            {
                _local_3 = CastleBean(_local_1.getItemAt(_local_2));
                _local_4 = 0;
                while (_local_4 < _local_3.fieldsArray.length)
                {
                    _local_5 = _local_3.getFields(_local_4);
                    _local_6 = new Coordinate(_local_5.id);
                    this.fieldMap[((_local_6.x + "/") + _local_6.y)] = true;
                    _local_4++;
                };
                _local_2++;
            };
        }

        private function parserString(_arg_1:String):Array
        {
            var _local_2:Array = new Array();
            var _local_3:int;
            var _local_4:int;
            while (_local_3 < this.mapNine_size)
            {
                _local_2.push(_arg_1.substr(_local_4, 2));
                _local_3++;
                _local_4 = (_local_4 + 2);
            };
            return (_local_2);
        }

        private function mouseUpHandler(_arg_1:MouseEvent):void
        {
            this.curClickTile = (_arg_1.target as Tile);
            trace(((("this.curClickTile: " + this.curClickTile.x) + ",") + this.curClickTile.y));
        }

        private function isSelfField(_arg_1:int, _arg_2:int):Boolean
        {
            return (this.fieldMap[((_arg_1 + "/") + _arg_2)]);
        }

        private function drawField(_arg_1:int, _arg_2:int, _arg_3:int, _arg_4:int, _arg_5:Array, _arg_6:ArrayCollection):void
        {
            var _local_7:Array = newDataArray(_arg_1, _arg_2, _arg_3, _arg_4, _arg_5, _arg_6);
            if (this.oldTileMap == null)
            {
                createFields(_local_7);
            }
            else
            {
                updateFields(_local_7);
            };
        }

        private function drawReqestGraph(_arg_1:Array, _arg_2:Point):void
        {
            var _local_4:Rectangle;
            var _local_3:int = 1;
            for each (_local_4 in _arg_1)
            {
                debugWin.graphics.beginFill((0x880000 + (0xFFFF * Math.random())), 0.5);
                debugWin.graphics.moveTo((_local_4.x * _local_3), (_local_4.y * _local_3));
                debugWin.graphics.lineTo(((_local_4.x + _local_4.width) * _local_3), (_local_4.y * _local_3));
                debugWin.graphics.lineTo(((_local_4.x + _local_4.width) * _local_3), ((_local_4.y + _local_4.height) * _local_3));
                debugWin.graphics.lineTo((_local_4.x * _local_3), ((_local_4.y + _local_4.height) * _local_3));
                debugWin.graphics.lineTo((_local_4.x * _local_3), (_local_4.y * _local_3));
                debugWin.graphics.endFill();
            };
            debugWin.graphics.beginFill(0xFF0000, 1);
            debugWin.graphics.drawCircle((_arg_2.x * _local_3), (_arg_2.y * _local_3), 2);
            debugWin.graphics.endFill();
        }

        private function newDataArray(_arg_1:int, _arg_2:int, _arg_3:int, _arg_4:int, _arg_5:Array, _arg_6:ArrayCollection):Array
        {
            var _local_12:int;
            var _local_13:int;
            var _local_14:Object;
            var _local_15:Point;
            var _local_16:MapCastleBean;
            var _local_17:Coordinate;
            var _local_18:int;
            var _local_7:Array = new Array();
            var _local_8:int = _arg_2;
            var _local_9:int;
            while (_local_8 <= _arg_4)
            {
                _local_12 = _arg_1;
                _local_13 = 0;
                while (_local_12 <= _arg_3)
                {
                    _local_14 = new Object();
                    _local_14["x"] = _local_12;
                    _local_14["y"] = _local_8;
                    if (((((_local_9 >= 6) && (_local_9 <= 14)) && (_local_13 >= 6)) && (_local_13 <= 14)))
                    {
                        _local_14["inScreen"] = true;
                    }
                    else
                    {
                        _local_14["inScreen"] = false;
                    };
                    _local_15 = toAddress(_local_14.x, _local_14.y);
                    _local_14["addr_x"] = int(_local_15.x);
                    _local_14["addr_y"] = int(_local_15.y);
                    _local_7.push(_local_14);
                    _local_12++;
                    _local_13++;
                };
                _local_8++;
                _local_9++;
            };
            var _local_10:int;
            while (_local_10 < this.mapNine_size)
            {
                _local_14 = _local_7[_local_10];
                if (_local_14 != null)
                {
                    _local_14["tl"] = _arg_5[_local_10];
                };
                _local_10++;
            };
            if (((_arg_6 == null) || (_arg_6.length < 1)))
            {
                return (_local_7);
            };
            var _local_11:int;
            while (_local_11 < _arg_6.length)
            {
                _local_16 = (_arg_6[_local_11] as MapCastleBean);
                _local_17 = new Coordinate(_local_16.id);
                _local_18 = 0;
                while (_local_18 < this.mapNine_size)
                {
                    _local_14 = _local_7[_local_18];
                    if (_local_14 != null)
                    {
                        if (((_local_14.addr_x == _local_17.x) && (_local_14.addr_y == _local_17.y)))
                        {
                            _local_14["castle"] = _local_16;
                            break;
                        };
                    };
                    _local_18++;
                };
                _local_11++;
            };
            return (_local_7);
        }

        public function setCityPos(_arg_1:int, _arg_2:int):void
        {
            cityPos.x = _arg_1;
            cityPos.y = _arg_2;
        }

        private function onMouseUp(_arg_1:MouseEvent=null):void
        {
            var _local_2:int;
            var _local_3:int;
            var _local_4:int;
            var _local_5:int;
            var _local_6:Point;
            tileMap.stopDrag();
            stage.removeEventListener(MouseEvent.MOUSE_UP, onMouseUp);
            mfin.x = tileMap.x;
            mfin.y = tileMap.y;
            distancePoint = mfin.subtract(mstart);
            distancePoint.x = int(distancePoint.x);
            distancePoint.y = int(distancePoint.y);
            if (((!(distancePoint.x == 0)) || (!(distancePoint.y == 0))))
            {
                _local_2 = int((distancePoint.x / TILE_WIDTH));
                _local_3 = int((distancePoint.y / TILE_HEIGHT));
                this.oldCenter_x = center_x;
                this.oldCenter_y = center_y;
                center_x = (center_x - _local_2);
                center_y = (center_y - _local_3);
                restX = (restX + (distancePoint.x % TILE_WIDTH));
                restY = (restY + (distancePoint.y % TILE_HEIGHT));
                if (int((restX / TILE_WIDTH)) != 0)
                {
                    center_x = (center_x - int((restX / TILE_WIDTH)));
                    restX = (restX % TILE_WIDTH);
                };
                if (int((restY / TILE_HEIGHT)) != 0)
                {
                    center_y = (center_y - int((restY / TILE_HEIGHT)));
                    restY = (restY % TILE_HEIGHT);
                };
                if (((!(this.oldCenter_x == this.center_x)) || (!(this.oldCenter_y == this.center_y))))
                {
                    _local_4 = Math.abs((lastRequestCenter.x - this.center_x));
                    _local_5 = Math.abs((lastRequestCenter.y - this.center_y));
                    trace(((("drag dx , dy " + _local_4) + ",") + _local_5));
                    if (((lastRequestCenter == null) || ((_local_4 > (appRect.width * 0.32)) || (_local_5 > (appRect.height * 0.32)))))
                    {
                        sendmapInfo(this.center_x, this.center_y);
                    };
                };
                restorePlayAll();
            }
            else
            {
                if (this.curClickTile != null)
                {
                    this.dispatchEvent(new WorldEvent(WorldEvent.EVENT_MSG, this.curClickTile));
                    _local_6 = this.tileMap.localToGlobal(new Point(this.curClickTile.x, this.curClickTile.y));
                };
            };
        }

        private function onMapInfo(_arg_1:MapInfoSimpleResponse):void
        {
            drawWorld(_arg_1.mapStr, _arg_1.x1, _arg_1.y1, _arg_1.x2, _arg_1.y2, _arg_1.castlesArray);
            this.stopPlayAll();
            this.restorePlayAll();
        }

        private function mouseMoveHandler(_arg_1:MouseEvent):void
        {
            this.worldMapTooltip.moveToMouse(_arg_1);
            if (_arg_1.buttonDown)
            {
                if (((Math.abs((lastMouseX - _arg_1.stageX)) >= 120) || (Math.abs((lastMouseY - _arg_1.stageY)) >= 70)))
                {
                    updateVisibleTiles();
                    lastMouseX = _arg_1.stageX;
                    lastMouseY = _arg_1.stageY;
                };
            };
        }

        public function setCenter(_arg_1:int, _arg_2:int):void
        {
            center_x = _arg_1;
            center_y = _arg_2;
            this.oldCenter_x = _arg_1;
            this.oldCenter_y = _arg_2;
            distancePoint = new Point(0, 0);
            restX = 0;
            restY = 0;
            var _local_3:Point = UIUtil.getCenterPointOfUI();
            tileMap.x = ((_local_3.x - (TILE_WIDTH * 0.5)) - (center_x * TILE_WIDTH));
            tileMap.y = ((_local_3.y - (TILE_HEIGHT * 0.5)) - (center_y * TILE_HEIGHT));
        }

        public function isTileVisible(_arg_1:Tile):Boolean
        {
            var _local_2:Point = this.tileMap.localToGlobal(new Point(_arg_1.x, _arg_1.y));
            var _local_3:Rectangle = new Rectangle(_local_2.x, _local_2.y, _arg_1.width, _arg_1.height);
            var _local_4:Point = UIUtil.getTopLeftPoint();
            var _local_5:Point = UIUtil.getBottomRightPoint();
            var _local_6:Rectangle = new Rectangle(_local_4.x, _local_4.y, (_local_5.x - _local_4.x), (_local_5.y - _local_4.y));
            if (_local_6.intersects(_local_3))
            {
                return (true);
            };
            return (false);
        }

        public function setPoint(_arg_1:int, _arg_2:int):void
        {
            this.oldTileMap = null;
            this.oldGroundMap = null;
            setCenter(_arg_1, _arg_2);
            sendmapInfo(this.center_x, this.center_y);
        }

        public function restorePlayAll():void
        {
            var _local_3:int;
            var _local_4:int;
            var _local_5:int;
            var _local_6:Tile;
            if ((((playing_list) || (Map.instance == null)) || (Map.instance.visible == false)))
            {
                return;
            };
            playing_list = new Object();
            var _local_1:Array = updateVisibleTiles();
            var _local_2:SharedObject = SharedObject.getLocal("performanceOpt", "/");
            if (_local_2.data.value != null)
            {
                if (int(_local_2.data.value) == 0)
                {
                    return;
                };
            };
            if (_local_1.length > 0)
            {
                playing_list = new Object();
                _local_3 = 0;
                _local_4 = 0;
                _local_3 = 0;
                while (((_local_4 < 10) && (_local_3 < _local_1.length)))
                {
                    _local_5 = _local_3;
                    _local_6 = _local_1[_local_5];
                    if (((_local_6._fieldType == FieldConstants.TYPE_FOREST) && (!(_local_6.level == 0))))
                    {
                        _local_6.play();
                        _local_4++;
                    };
                    _local_3++;
                };
                _local_3 = 0;
                while (((_local_4 < 10) && (_local_3 < _local_1.length)))
                {
                    _local_5 = int((Math.random() * _local_1.length));
                    _local_6 = _local_1[_local_5];
                    if (playing_list[_local_6] == null)
                    {
                        _local_6.play();
                        _local_3++;
                    };
                };
            };
        }

        private function changFlag(_arg_1:CastleFlagEvent):void
        {
            var _local_2:int;
            var _local_3:Tile;
            var _local_4:CastleFlag;
            var _local_5:CastleFlagMc;
            while (_local_2 < this.tileArray.length)
            {
                if ((tileArray[_local_2] as Tile).mapCastleBean != null)
                {
                    if ((tileArray[_local_2] as Tile).mapCastleBean.userName == _arg_1.castleRoleName)
                    {
                        _local_3 = (tileArray[_local_2] as Tile);
                        _local_4 = (_local_3.getCastleFlag() as CastleFlag);
                        _local_5 = (_local_4.getCastleFlagMc() as CastleFlagMc);
                        if (_arg_1.statues == DeclaredWarConstants.STATUS_PREPARATIONS)
                        {
                            _local_5.gotoAndStopNative("purple_s");
                        }
                        else
                        {
                            if (_arg_1.statues == DeclaredWarConstants.STATUS_WAR)
                            {
                                _local_5.gotoAndStopNative("red_s");
                            }
                            else
                            {
                                _local_5.gotoAndStopNative("white_s");
                            };
                        };
                    };
                };
                _local_2++;
            };
        }

        private function createMapGround():void
        {
            var _local_5:int;
            if (this.oldGroundMap == null)
            {
                this.oldGroundMap = new Array();
            };
            var _local_1:int = int(((appRect.width * TILE_WIDTH) / (TILE_WIDTH * 7)));
            var _local_2:int = int(((appRect.height * TILE_HEIGHT) / (TILE_HEIGHT * 7)));
            if ((appRect.width % 7) > 0)
            {
                _local_1 = (_local_1 + 1);
            };
            if ((appRect.height % 7) > 0)
            {
                _local_2 = (_local_2 + 1);
            };
            _local_1 = (_local_1 + 4);
            _local_2 = (_local_2 + 4);
            var _local_3:Bitmap;
            var _local_4:int;
            while (_local_4 < _local_2)
            {
                _local_5 = 0;
                while (_local_5 <= _local_1)
                {
                    _local_3 = new Bitmap(tilePic);
                    groundArray[((_local_4 * _local_1) + _local_5)] = _local_3;
                    tileMap.addChildAt(_local_3, 0);
                    _local_5++;
                };
                _local_4++;
            };
        }

        public function stopPlayAll():void
        {
            var _local_1:Tile;
            if (playing_list == null)
            {
                return;
            };
            playing_list = null;
            for each (_local_1 in tileArray)
            {
                if (!isTileVisible(_local_1))
                {
                    _local_1.removeMyHostFlags();
                    _local_1.removeCastleFlag();
                    _local_1.removeAnimation();
                }
                else
                {
                    _local_1.stop();
                };
            };
        }

        public function resetPoint():void
        {
            setPoint(this.center_x, this.center_y);
        }

        private function moveGroundMap(_arg_1:int, _arg_2:int):void
        {
            var _local_3:int = int(Math.ceil(((appRect.width - 1) / 2)));
            var _local_4:int = int(Math.ceil(((appRect.height - 1) / 2)));
            var _local_5:int = ((_arg_1 - _local_3) % groundMaxX);
            var _local_6:int = ((_arg_2 - _local_4) % groundMaxY);
            var _local_7:int = (_arg_1 * TILE_WIDTH);
            var _local_8:int = (_arg_2 * TILE_HEIGHT);
            var _local_9:int = (((_local_7 - (TILE_WIDTH * _local_3)) - (_local_5 * TILE_WIDTH)) - (2 * tilePic.width));
            var _local_10:int = (((_local_8 - (TILE_HEIGHT * _local_4)) - (_local_6 * TILE_HEIGHT)) - (2 * tilePic.height));
            var _local_11:int = int(((appRect.width * TILE_WIDTH) / (TILE_WIDTH * 7)));
            var _local_12:int = int(((appRect.height * TILE_HEIGHT) / (TILE_HEIGHT * 7)));
            if ((appRect.width % 7) > 0)
            {
                _local_11 = (_local_11 + 1);
            };
            if ((appRect.height % 7) > 0)
            {
                _local_12 = (_local_12 + 1);
            };
            _local_11 = (_local_11 + 4);
            _local_12 = (_local_12 + 4);
            var _local_13:Bitmap;
            _arg_2 = 0;
            while (_arg_2 < _local_12)
            {
                _arg_1 = 0;
                while (_arg_1 <= _local_11)
                {
                    _local_13 = groundArray[((_arg_2 * _local_11) + _arg_1)];
                    _local_13.x = (_local_9 + (_local_13.width * _arg_1));
                    _local_13.y = (_local_10 + (_local_13.height * _arg_2));
                    _arg_1++;
                };
                _arg_2++;
            };
        }

        public function resizeListener(_arg_1:Event):void
        {
            var _local_2:Point = UIUtil.getTopLeftPoint();
            var _local_3:Point = UIUtil.getBottomRightPoint();
            trace(((("stageWidth: " + stage.stageWidth) + " stageHeight: ") + stage.stageHeight));
            appWidth = stage.stageWidth;
            appHeight = stage.stageHeight;
            appRect.width = Math.ceil(((appWidth * 3) / TILE_WIDTH));
            appRect.height = Math.ceil(((appHeight * 3) / TILE_HEIGHT));
            mapNine_size = (appRect.width * appRect.height);
            setPoint(this.center_x, this.center_y);
        }

        private function setAngle():void
        {
            var _local_1:Coordinate = new Coordinate(Context.getInstance().getCurCastle().fieldId);
            if (Math.abs((_local_1.x - center_x)) > (Context.mapSizeX / 2))
            {
                _local_1.x = -(Context.mapSizeX - _local_1.x);
            };
            if (Math.abs((_local_1.y - center_y)) > (Context.mapSizeY / 2))
            {
                _local_1.y = -(Context.mapSizeY - _local_1.y);
            };
            var _local_2:Number = ((Math.atan2(((_local_1.y * TILE_HEIGHT) - (this.center_y * TILE_HEIGHT)), (((_local_1.x * TILE_WIDTH) - (this.center_x * TILE_WIDTH)) + 420)) / Math.PI) * 180);
            this.dispatchEvent(new MapResetPointEvent(MapResetPointEvent.MAP_RESET, _local_2));
        }

        private function mouseOutHandler(_arg_1:MouseEvent):void
        {
            this.selectedCirle.visible = false;
            PopUpManager.removePopUp(this.worldMapTooltip);
        }

        public function sendmapInfo(_arg_1:int, _arg_2:int):void
        {
            if (lastRequestCenter == null)
            {
                lastRequestCenter = new Point(_arg_1, _arg_2);
            };
            lastRequestCenter.x = _arg_1;
            lastRequestCenter.y = _arg_2;
            var _local_3:int = int((_arg_1 - Math.ceil(((appRect.width - 1) / 2))));
            var _local_4:int = int((_arg_2 - Math.ceil(((appRect.height - 1) / 2))));
            var _local_5:int = int((_arg_1 + Math.floor(((appRect.width - 1) / 2))));
            var _local_6:int = int((_arg_2 + Math.floor(((appRect.height - 1) / 2))));
            ActionFactory.getInstance().getCommonCommands().mapInfoSimple(Context.getInstance().getCurCastle().id, _local_3, _local_4, _local_5, _local_6);
            CursorManager.removeBusyCursor();
        }

        private function drawWorld(_arg_1:String, _arg_2:int, _arg_3:int, _arg_4:int, _arg_5:int, _arg_6:ArrayCollection):void
        {
            refreshMyFieldMap();
            oldTileMap = null;
            drawGround(_arg_2, _arg_3, _arg_4, _arg_5);
            drawField(_arg_2, _arg_3, _arg_4, _arg_5, parserString(_arg_1), _arg_6);
            setAngle();
        }

        private function initDebugWin():void
        {
            debugWin.y = 200;
            debugWin.x = 20;
            debugWin.graphics.beginFill(0xFFFFFF, 1);
            debugWin.graphics.drawRect(0, 0, Context.mapSizeX, Context.mapSizeY);
            debugWin.graphics.endFill();
            this.addChild(debugWin);
        }

        private function setMapSize():void
        {
            var _local_1:Point = UIUtil.getTopLeftPoint();
            var _local_2:Point = UIUtil.getBottomRightPoint();
            appWidth = (_local_2.x - _local_1.x);
            appHeight = (_local_2.y - _local_1.y);
            appRect.width = Math.ceil(((appWidth * 3) / TILE_WIDTH));
            appRect.height = Math.ceil(((appHeight * 3) / TILE_HEIGHT));
            mapNine_size = (appRect.width * appRect.height);
            appRect.x = _local_1.x;
            appRect.y = _local_1.y;
            tileArray = new Array();
            groundArray = new Array();
            tileMap = new UIComponent();
        }

        public function updateVisibleTiles():Array
        {
            var _local_2:Tile;
            var _local_1:Array = new Array();
            var _local_3:int;
            while (_local_3 < this.tileArray.length)
            {
                _local_2 = tileArray[_local_3];
                if (isTileVisible(_local_2))
                {
                    _local_1.push(_local_2);
                }
                else
                {
                    _local_2.removeMyHostFlags();
                    _local_2.removeCastleFlag();
                    _local_2.removeAnimation();
                };
                _local_3++;
            };
            for each (_local_2 in _local_1)
            {
                _local_2.addAnimation();
                _local_2.addCastleFlag();
                _local_2.addMyHostFlags();
            };
            return (_local_1);
        }

        private function onMouseDown(_arg_1:MouseEvent=null):void
        {
            lastMouseX = _arg_1.stageX;
            lastMouseY = _arg_1.stageY;
            mstart.x = tileMap.x;
            mstart.y = tileMap.y;
            this.curClickTile = null;
            tileMap.startDrag();
            stage.addEventListener(MouseEvent.MOUSE_UP, onMouseUp);
            stopPlayAll();
        }

        public function onFloorLoaded(_arg_1:Event):void
        {
            var _local_2:Bitmap = bkimg.getBitmap();
            tilePic = _local_2.bitmapData;
            this.selectedCirle = new EvonyAnimation();
            this.selectedCirle.mouseEnabled = false;
            this.selectedCirle.mouseChildren = false;
            this.selectedCirle.load(EvonyAnimation.TYPE_Select, -1);
            tileMap.x = 0;
            tileMap.y = 0;
            tileMap.cacheAsBitmap = true;
            tileMap.addEventListener(MouseEvent.MOUSE_DOWN, onMouseDown);
            createTiles();
            this.createMapGround();
            this.addChild(tileMap);
            tileMap.addChild(this.selectedCirle);
            tileMap.addChild(this.worldMapTooltip);
            this.selectedCirle.visible = false;
            stage.addEventListener(Event.RESIZE, resizeListener);
            ResponseDispatcher.getInstance().addEventListener(ResponseDispatcher.COMMON_MAP_INFO_SIMPLE, onMapInfo);
            MsgDispacther.getInstance().addEventListener(CastleFlagEvent.EVENT_NAME, changFlag);
        }

        private function updateFields(_arg_1:Array):void
        {
            var _local_7:int;
            var _local_8:Object;
            var _local_9:Object;
            var _local_10:int;
            var _local_11:int;
            var _local_12:String;
            var _local_13:int;
            var _local_14:MapCastleBean;
            var _local_2:Tile;
            var _local_3:Array = new Array();
            var _local_4:Array = new Array();
            var _local_5:int;
            while (_local_5 < this.mapNine_size)
            {
                _local_8 = _arg_1[_local_5];
                _local_9 = this.oldTileMap[((_local_8.x + "/") + _local_8.y)];
                if (_local_9 != null)
                {
                    _local_2 = (_local_9 as Tile);
                    _local_10 = _local_8.x;
                    _local_11 = _local_8.y;
                    _local_12 = _local_8.tl;
                    _local_13 = 4;
                    if (_local_8.castle != null)
                    {
                        _local_14 = (_local_8.castle as MapCastleBean);
                        _local_13 = _local_14.powerLevel;
                    };
                    _local_2.setFirstMap(_local_12, isSelfField(_local_8.addr_x, _local_8.addr_y), new Point(_local_8.addr_x, _local_8.addr_y), _local_13, 0);
                    if (_local_8.castle != null)
                    {
                        _local_14 = (_local_8.castle as MapCastleBean);
                        _local_2.setSecondMap(_local_14, _local_8.inScreen);
                    };
                    _local_3.push(_local_2);
                }
                else
                {
                    _local_4.push(_local_8);
                };
                _local_5++;
            };
            var _local_6:Array = new Array();
            for each (_local_2 in this.oldTileMap)
            {
                if (_local_3.indexOf(_local_2) < 0)
                {
                    _local_6.push(_local_2);
                };
            };
            _local_7 = 4;
            _local_5 = 0;
            while (_local_5 < _local_4.length)
            {
                _local_8 = _local_4[_local_5];
                _local_2 = (_local_6[_local_5] as Tile);
                if (_local_2 != null)
                {
                    _local_10 = _local_8.x;
                    _local_11 = _local_8.y;
                    _local_2.x = (_local_10 * TILE_WIDTH);
                    _local_2.y = (_local_11 * TILE_HEIGHT);
                    _local_12 = _local_8.tl;
                    _local_7 = 4;
                    if (_local_8.castle != null)
                    {
                        _local_14 = (_local_8.castle as MapCastleBean);
                        _local_7 = _local_14.powerLevel;
                    };
                    _local_2.setFirstMap(_local_12, isSelfField(_local_8.addr_x, _local_8.addr_y), new Point(_local_8.addr_x, _local_8.addr_y), _local_7, 0);
                    if (_local_8.castle != null)
                    {
                        _local_14 = (_local_8.castle as MapCastleBean);
                        _local_2.setSecondMap(_local_14, _local_8.inScreen);
                    };
                    _local_3.push(_local_2);
                };
                _local_5++;
            };
            this.oldTileMap = new Object();
            _local_5 = 0;
            while (_local_5 < _local_3.length)
            {
                _local_2 = (_local_3[_local_5] as Tile);
                _local_10 = int((_local_2.x / TILE_WIDTH));
                _local_11 = int((_local_2.y / TILE_HEIGHT));
                this.oldTileMap[((_local_10 + "/") + _local_11)] = _local_2;
                _local_5++;
            };
        }

        private function drawGround(_arg_1:int, _arg_2:int, _arg_3:int, _arg_4:int):void
        {
            if (oldTileMap == null)
            {
                createMapGround();
            };
            moveGroundMap(this.center_x, this.center_y);
        }

        private function createFields(_arg_1:Array):void
        {
            var _local_3:Tile;
            var _local_4:Object;
            var _local_5:int;
            var _local_6:int;
            var _local_7:int;
            var _local_8:MapCastleBean;
            var _local_9:String;
            oldTileMap = new Object();
            var _local_2:int;
            while (_local_2 < _arg_1.length)
            {
                _local_3 = (this.tileArray[_local_2] as Tile);
                if (_local_3 == null)
                {
                    _local_3 = new Tile();
                    _local_3.width = TILE_WIDTH;
                    _local_3.height = TILE_HEIGHT;
                    _local_3.name = (("tile(" + _local_2) + ")");
                    _local_3.mouseChildren = false;
                    _local_3.addEventListener(MouseEvent.MOUSE_OVER, mouseOverHandler);
                    _local_3.addEventListener(MouseEvent.MOUSE_MOVE, mouseMoveHandler);
                    _local_3.addEventListener(MouseEvent.MOUSE_OUT, mouseOutHandler);
                    _local_3.addEventListener(MouseEvent.MOUSE_UP, mouseUpHandler);
                    this.tileArray.push(_local_3);
                    tileMap.addChild(_local_3);
                };
                _local_4 = _arg_1[_local_2];
                _local_5 = _local_4.x;
                _local_6 = _local_4.y;
                _local_3.x = (_local_5 * TILE_WIDTH);
                _local_3.y = (_local_6 * TILE_HEIGHT);
                _local_7 = 4;
                if (_local_4.castle != null)
                {
                    _local_8 = (_local_4.castle as MapCastleBean);
                    if (_local_8.powerLevel < 4)
                    {
                        _local_7 = _local_8.powerLevel;
                    };
                };
                _local_9 = _local_4.tl;
                if (_local_9 != null)
                {
                    _local_3.setFirstMap(_local_9, isSelfField(_local_4.addr_x, _local_4.addr_y), new Point(_local_4.addr_x, _local_4.addr_y), _local_7, (((_local_2 % 20) == 0) ? 1 : 0));
                };
                if (_local_4.castle != null)
                {
                    _local_3.setSecondMap(_local_8, _local_4.inScreen);
                };
                oldTileMap[((_local_5 + "/") + _local_6)] = _local_3;
                _local_2++;
            };
        }

        private function createTiles():void
        {
            var _local_2:Tile;
            trace((this.className + ".createTiles()"));
            var _local_1:int;
            while (_local_1 < this.mapNine_size)
            {
                _local_2 = new Tile();
                _local_2.width = TILE_WIDTH;
                _local_2.height = TILE_HEIGHT;
                _local_2.name = (("tile(" + _local_1) + ")");
                _local_2.mouseChildren = false;
                _local_2.addEventListener(MouseEvent.MOUSE_OVER, mouseOverHandler);
                _local_2.addEventListener(MouseEvent.MOUSE_MOVE, mouseMoveHandler);
                _local_2.addEventListener(MouseEvent.MOUSE_OUT, mouseOutHandler);
                _local_2.addEventListener(MouseEvent.MOUSE_UP, mouseUpHandler);
                this.tileArray.push(_local_2);
                tileMap.addChild(_local_2);
                _local_1++;
            };
        }

        private function mouseOverHandler(_arg_1:MouseEvent):void
        {
            var _local_2:Tile = (_arg_1.target as Tile);
            this.selectedCirle.x = _local_2.x;
            this.selectedCirle.y = _local_2.y;
            this.selectedCirle.visible = true;
            var _local_3:Number = NewArmyWin.getInstance().countDistance(cityPos, _local_2.getAddress());
            this.worldMapTooltip.setTile(_local_2, _local_3);
            PopUpManager.addPopUp(this.worldMapTooltip, this);
            this.worldMapTooltip.moveToMouse(_arg_1);
        }

        private function toAddress(_arg_1:int, _arg_2:int):Point
        {
            var _local_3:Point = new Point();
            var _local_4:int = Context.mapSizeX;
            var _local_5:int = Context.mapSizeY;
            var _local_6:int = _arg_1;
            var _local_7:int = _arg_2;
            if (((_local_6 < 0) || (_local_6 >= _local_4)))
            {
                if (_local_6 < 0)
                {
                    _local_6 = (_local_4 + (_local_6 % _local_5));
                }
                else
                {
                    _local_6 = (_local_6 % _local_4);
                };
            };
            if (((_local_7 < 0) || (_local_7 >= _local_5)))
            {
                if (_local_7 < 0)
                {
                    _local_7 = (_local_5 + (_local_7 % _local_5));
                }
                else
                {
                    _local_7 = (_local_7 % _local_5);
                };
            };
            _local_3.x = _local_6;
            _local_3.y = _local_7;
            return (_local_3);
        }


    }
}//package view.castle.world

