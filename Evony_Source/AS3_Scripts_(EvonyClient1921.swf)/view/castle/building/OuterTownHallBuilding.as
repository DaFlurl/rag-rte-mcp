// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//view.castle.building.OuterTownHallBuilding

package view.castle.building
{
    import mx.containers.Canvas;
    import mx.controls.Image;
    import com.evony.common.beans.BuildingBean;
    import flash.display.MovieClip;
    import mx.binding.utils.ChangeWatcher;
    import mx.core.UIComponentDescriptor;
    import com.evony.common.beans.CastleBean;
    import com.evony.Context;
    import mx.collections.ArrayCollection;
    import mx.core.mx_internal;
    import flash.events.MouseEvent;
    import mx.events.PropertyChangeEvent;
    import com.evony.common.constants.BuildingConstants;
    import mx.binding.utils.BindingUtils;
    import flash.events.Event;
    import com.evony.MsgDispacther;
    import view.MainWin;
    import mx.events.FlexEvent;
    import com.evony.util.ImageSmooth;
    import mx.core.BitmapAsset;
    import flash.display.Bitmap;
    import flash.display.*;
    import flash.geom.*;
    import flash.media.*;
    import flash.text.*;
    import flash.events.*;
    import mx.styles.*;
    import mx.binding.*;
    import flash.utils.*;
    import flash.accessibility.*;
    import flash.filters.*;
    import flash.system.*;
    import flash.xml.*;
    import flash.ui.*;
    import flash.net.*;
    import flash.external.*;
    import flash.debugger.*;
    import flash.errors.*;
    import flash.printing.*;
    import flash.profiler.*;

    public class OuterTownHallBuilding extends Canvas 
    {

        private var _759341245castleImage:Image;
        private var _1345334299townHallbean:BuildingBean;
        private var townBuilding:MovieClip;
        private var cwr:ChangeWatcher;

        private var _documentDescriptor_:UIComponentDescriptor = new UIComponentDescriptor({
            "type":Canvas,
            "propertiesFactory":function ():Object
            {
                return ({
                    "creationPolicy":"all",
                    "childDescriptors":[new UIComponentDescriptor({
                        "type":Image,
                        "id":"castleImage",
                        "events":{
                            "complete":"__castleImage_complete",
                            "click":"__castleImage_click",
                            "mouseOut":"__castleImage_mouseOut",
                            "mouseOver":"__castleImage_mouseOver"
                        },
                        "propertiesFactory":function ():Object
                        {
                            return ({
                                "source":"images/imagesNewUI/OutSideCastle1.png",
                                "toolTip":"Enter Town"
                            });
                        }
                    })]
                });
            }
        });
        private var _691506344curCastle:CastleBean = Context.getInstance().getCurCastle();
        private var buildingsAry:ArrayCollection = new ArrayCollection();

        public function OuterTownHallBuilding()
        {
            mx_internal::_document = this;
            this.percentWidth = 100;
            this.percentHeight = 100;
            this.creationPolicy = "all";
            this.horizontalScrollPolicy = "off";
            this.verticalScrollPolicy = "off";
            this.addEventListener("creationComplete", ___OuterTownHallBuilding_Canvas1_creationComplete);
        }

        [Bindable(event="propertyChange")]
        public function get castleImage():Image
        {
            return (this._759341245castleImage);
        }

        public function __castleImage_mouseOut(_arg_1:MouseEvent):void
        {
            mouseOutEffect();
        }

        public function set castleImage(_arg_1:Image):void
        {
            var _local_2:Object = this._759341245castleImage;
            if (_local_2 !== _arg_1)
            {
                this._759341245castleImage = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "castleImage", _local_2, _arg_1));
            };
        }

        private function onCurCastleChange(_arg_1:Event):void
        {
            var _local_2:BuildingBean;
            this.curCastle = Context.getInstance().getCurCastle();
            buildingsAry = this.curCastle.buildingsArray;
            for each (_local_2 in buildingsAry)
            {
                if (_local_2.typeId == BuildingConstants.TYPE_TOWN_HALL)
                {
                    townHallbean = _local_2;
                    if (cwr != null)
                    {
                        cwr.unwatch();
                    };
                    cwr = BindingUtils.bindProperty(this, "townHallLevelChange", townHallbean, "level");
                };
            };
        }

        private function mouseOverEffect():void
        {
            this.castleImage.alpha = 0.5;
        }

        private function set townHallbean(_arg_1:BuildingBean):void
        {
            var _local_2:Object = this._1345334299townHallbean;
            if (_local_2 !== _arg_1)
            {
                this._1345334299townHallbean = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "townHallbean", _local_2, _arg_1));
            };
        }

        override public function initialize():void
        {
            (mx_internal::setDocumentDescriptor(_documentDescriptor_));
            super.initialize();
        }

        [Bindable(event="propertyChange")]
        private function get townHallbean():BuildingBean
        {
            return (this._1345334299townHallbean);
        }

        public function __castleImage_complete(_arg_1:Event):void
        {
            loadComplete(_arg_1);
        }

        private function overHandler(_arg_1:MouseEvent):void
        {
            var _local_2:Object = _arg_1.target;
            _local_2.gotoAndStop((_local_2.currentFrame + 1));
        }

        [Bindable(event="propertyChange")]
        private function get curCastle():CastleBean
        {
            return (this._691506344curCastle);
        }

        public function set townHallLevelChange(_arg_1:int):void
        {
            var _local_2:int = townHallbean.level;
            if (((_local_2 >= 3) && (_local_2 <= 6)))
            {
                castleImage.source = "images/imagesNewUI/OutSideCastle2.png";
                castleImage.y = 0;
            }
            else
            {
                if (((_local_2 >= 7) && (_local_2 <= 9)))
                {
                    castleImage.source = "images/imagesNewUI/OutSideCastle3.png";
                    castleImage.y = 0;
                }
                else
                {
                    if (_local_2 == 10)
                    {
                        castleImage.source = "images/imagesNewUI/OutSideCastle4.png";
                    }
                    else
                    {
                        castleImage.source = "images/imagesNewUI/OutSideCastle1.png";
                        castleImage.y = 0;
                    };
                };
            };
        }

        private function mouseOutEffect():void
        {
            this.castleImage.alpha = 1;
        }

        private function outHandler(_arg_1:MouseEvent):void
        {
            var _local_2:Object = _arg_1.target;
            _local_2.gotoAndStop((_local_2.currentFrame - 1));
        }

        private function init():void
        {
            var _local_1:BuildingBean;
            this.curCastle = Context.getInstance().getCurCastle();
            buildingsAry = this.curCastle.buildingsArray;
            for each (_local_1 in buildingsAry)
            {
                if (_local_1.typeId == BuildingConstants.TYPE_TOWN_HALL)
                {
                    townHallbean = _local_1;
                    if (cwr != null)
                    {
                        cwr.unwatch();
                    };
                    cwr = BindingUtils.bindProperty(this, "townHallLevelChange", townHallbean, "level");
                };
            };
            MsgDispacther.getInstance().addEventListener(Context.EVENT_CASTLE_CHANGE, onCurCastleChange);
        }

        public function __castleImage_mouseOver(_arg_1:MouseEvent):void
        {
            mouseOverEffect();
        }

        private function onClick(_arg_1:MouseEvent):void
        {
            MainWin.instance.onCityInClick();
        }

        public function ___OuterTownHallBuilding_Canvas1_creationComplete(_arg_1:FlexEvent):void
        {
            init();
        }

        private function set curCastle(_arg_1:CastleBean):void
        {
            var _local_2:Object = this._691506344curCastle;
            if (_local_2 !== _arg_1)
            {
                this._691506344curCastle = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "curCastle", _local_2, _arg_1));
            };
        }

        public function __castleImage_click(_arg_1:MouseEvent):void
        {
            onClick(_arg_1);
        }

        private function loadComplete(_arg_1:Event):void
        {
            ImageSmooth.onLoadComplete(_arg_1);
            if (_arg_1.currentTarget.content != null)
            {
                if ((_arg_1.currentTarget.content is BitmapAsset))
                {
                    BitmapAsset(_arg_1.currentTarget.content).x = (-(BitmapAsset(_arg_1.currentTarget.content).width) / 2);
                    BitmapAsset(_arg_1.currentTarget.content).y = (-(BitmapAsset(_arg_1.currentTarget.content).height) / 2);
                }
                else
                {
                    Bitmap(_arg_1.currentTarget.content).x = (-(Bitmap(_arg_1.currentTarget.content).width) / 2);
                    Bitmap(_arg_1.currentTarget.content).y = (-(Bitmap(_arg_1.currentTarget.content).height) / 2);
                    Bitmap(_arg_1.currentTarget.content).smoothing = true;
                };
            };
        }


    }
}//package view.castle.building

