// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//view.castleInfo.HeroIconFile

package view.castleInfo
{
    import mx.containers.Canvas;
    import mx.binding.IBindingClient;
    import mx.binding.IWatcherSetupUtil;
    import mx.controls.Label;
    import mx.controls.Image;
    import mx.core.UIComponentDescriptor;
    import mx.core.mx_internal;
    import mx.binding.Binding;
    import flash.utils.getDefinitionByName;
    import flash.events.MouseEvent;
    import mx.events.PropertyChangeEvent;
    import com.evony.common.beans.TroopProduceListBean;
    import view.module.barrack.SWDisband;
    import view.MainWin;
    import mx.events.FlexEvent;
    import com.evony.factory.ImageManager;
    import com.evony.eum.TroopEumDefine;
    import com.evony.eum.TroopEum;
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

    use namespace mx_internal;

    public class HeroIconFile extends Canvas implements IBindingClient 
    {

        private static var _watcherSetupUtil:IWatcherSetupUtil;

        private var _1480346608_count:int;
        private var _1314794686_soldierId:int;
        private var _797651307_soldierTpye:String;
        private var _1034376950numTxt:Label;
        private var _19956407_imgPath:Object;
        private var _2085227887iconFilePanel:Image;

        private var _documentDescriptor_:UIComponentDescriptor = new UIComponentDescriptor({
            "type":Canvas,
            "propertiesFactory":function ():Object
            {
                return ({
                    "width":105,
                    "height":28,
                    "childDescriptors":[new UIComponentDescriptor({
                        "type":Canvas,
                        "stylesFactory":function ():void
                        {
                            this.verticalCenter = "0";
                            this.left = "4";
                        },
                        "propertiesFactory":function ():Object
                        {
                            return ({
                                "width":25,
                                "height":25,
                                "childDescriptors":[new UIComponentDescriptor({
                                    "type":Image,
                                    "id":"iconFilePanel",
                                    "events":{
                                        "click":"__iconFilePanel_click",
                                        "creationComplete":"__iconFilePanel_creationComplete"
                                    },
                                    "stylesFactory":function ():void
                                    {
                                        this.horizontalCenter = "0";
                                        this.verticalCenter = "0";
                                    },
                                    "propertiesFactory":function ():Object
                                    {
                                        return ({
                                            "width":25,
                                            "height":25
                                        });
                                    }
                                })]
                            });
                        }
                    }), new UIComponentDescriptor({
                        "type":Canvas,
                        "stylesFactory":function ():void
                        {
                            this.left = "38";
                        },
                        "propertiesFactory":function ():Object
                        {
                            return ({
                                "width":65,
                                "height":25,
                                "childDescriptors":[new UIComponentDescriptor({
                                    "type":Label,
                                    "id":"numTxt",
                                    "stylesFactory":function ():void
                                    {
                                        this.right = "0";
                                        this.textAlign = "right";
                                        this.fontWeight = "bold";
                                        this.verticalCenter = "0";
                                    },
                                    "propertiesFactory":function ():Object
                                    {
                                        return ({
                                            "width":65,
                                            "styleName":"tableContent3",
                                            "height":20
                                        });
                                    }
                                })]
                            });
                        }
                    })]
                });
            }
        });
        mx_internal var _bindings:Array = [];
        mx_internal var _watchers:Array = [];
        mx_internal var _bindingsByDestination:Object = {};
        mx_internal var _bindingsBeginWithWord:Object = {};

        public function HeroIconFile()
        {
            mx_internal::_document = this;
            this.width = 105;
            this.height = 28;
        }

        public static function set watcherSetupUtil(_arg_1:IWatcherSetupUtil):void
        {
            HeroIconFile._watcherSetupUtil = _arg_1;
        }


        private function _HeroIconFile_bindingsSetup():Array
        {
            var binding:Binding;
            var result:Array = [];
            binding = new Binding(this, function ():Object
            {
                return (this._imgPath);
            }, function (_arg_1:Object):void
            {
                iconFilePanel.source = _arg_1;
            }, "iconFilePanel.source");
            result[0] = binding;
            binding = new Binding(this, function ():String
            {
                var _local_1:* = _soldierTpye;
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                iconFilePanel.toolTip = _arg_1;
            }, "iconFilePanel.toolTip");
            result[1] = binding;
            binding = new Binding(this, function ():String
            {
                var _local_1:* = _count;
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                numTxt.text = _arg_1;
            }, "numTxt.text");
            result[2] = binding;
            return (result);
        }

        [Bindable(event="propertyChange")]
        private function get _imgPath():Object
        {
            return (this._19956407_imgPath);
        }

        private function _HeroIconFile_bindingExprs():void
        {
            var _local_1:*;
            _local_1 = this._imgPath;
            _local_1 = _soldierTpye;
            _local_1 = _count;
        }

        [Bindable(event="propertyChange")]
        private function get _soldierId():int
        {
            return (this._1314794686_soldierId);
        }

        override public function initialize():void
        {
            var target:HeroIconFile;
            var watcherSetupUtilClass:Object;
            (mx_internal::setDocumentDescriptor(_documentDescriptor_));
            var bindings:Array = _HeroIconFile_bindingsSetup();
            var watchers:Array = [];
            target = this;
            if (_watcherSetupUtil == null)
            {
                watcherSetupUtilClass = getDefinitionByName("_view_castleInfo_HeroIconFileWatcherSetupUtil");
                var _local_2:* = watcherSetupUtilClass;
                (_local_2["init"](null));
            };
            _watcherSetupUtil.setup(this, function (_arg_1:String):*
            {
                return (target[_arg_1]);
            }, bindings, watchers);
            var i:uint;
            while (i < bindings.length)
            {
                Binding(bindings[i]).execute();
                i++;
            };
            mx_internal::_bindings = mx_internal::_bindings.concat(bindings);
            mx_internal::_watchers = mx_internal::_watchers.concat(watchers);
            super.initialize();
        }

        public function __iconFilePanel_click(_arg_1:MouseEvent):void
        {
            onDisbandBtnClick();
        }

        [Bindable(event="propertyChange")]
        public function get numTxt():Label
        {
            return (this._1034376950numTxt);
        }

        public function set numTxt(_arg_1:Label):void
        {
            var _local_2:Object = this._1034376950numTxt;
            if (_local_2 !== _arg_1)
            {
                this._1034376950numTxt = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "numTxt", _local_2, _arg_1));
            };
        }

        public function set count(_arg_1:int):void
        {
            this._count = _arg_1;
        }

        private function onDisbandBtnClick():void
        {
            var _local_1:TroopProduceListBean = new TroopProduceListBean();
            _local_1.typeId = _soldierId;
            SWDisband.show(MainWin.instance, _local_1);
        }

        private function set _count(_arg_1:int):void
        {
            var _local_2:Object = this._1480346608_count;
            if (_local_2 !== _arg_1)
            {
                this._1480346608_count = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "_count", _local_2, _arg_1));
            };
        }

        private function set _imgPath(_arg_1:Object):void
        {
            var _local_2:Object = this._19956407_imgPath;
            if (_local_2 !== _arg_1)
            {
                this._19956407_imgPath = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "_imgPath", _local_2, _arg_1));
            };
        }

        public function set iconFilePanel(_arg_1:Image):void
        {
            var _local_2:Object = this._2085227887iconFilePanel;
            if (_local_2 !== _arg_1)
            {
                this._2085227887iconFilePanel = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "iconFilePanel", _local_2, _arg_1));
            };
        }

        public function __iconFilePanel_creationComplete(_arg_1:FlexEvent):void
        {
            onLoadComplete(_arg_1);
        }

        private function set _soldierTpye(_arg_1:String):void
        {
            var _local_2:Object = this._797651307_soldierTpye;
            if (_local_2 !== _arg_1)
            {
                this._797651307_soldierTpye = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "_soldierTpye", _local_2, _arg_1));
            };
        }

        [Bindable(event="propertyChange")]
        public function get iconFilePanel():Image
        {
            return (this._2085227887iconFilePanel);
        }

        [Bindable(event="propertyChange")]
        private function get _soldierTpye():String
        {
            return (this._797651307_soldierTpye);
        }

        public function set soldierId(_arg_1:int):void
        {
            this._soldierId = _arg_1;
            this._imgPath = ImageManager.getTroopSmallLogo(_arg_1);
            var _local_2:TroopEum = TroopEumDefine.getTroopEumByType(_arg_1);
            this._soldierTpye = _local_2.name;
        }

        private function set _soldierId(_arg_1:int):void
        {
            var _local_2:Object = this._1314794686_soldierId;
            if (_local_2 !== _arg_1)
            {
                this._1314794686_soldierId = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "_soldierId", _local_2, _arg_1));
            };
        }

        [Bindable(event="propertyChange")]
        private function get _count():int
        {
            return (this._1480346608_count);
        }

        private function onLoadComplete(_arg_1:FlexEvent):void
        {
            if (_arg_1.currentTarget.content != null)
            {
                if ((_arg_1.currentTarget.content is BitmapAsset))
                {
                    BitmapAsset(_arg_1.currentTarget.content).smoothing = true;
                }
                else
                {
                    Bitmap(_arg_1.currentTarget.content).smoothing = true;
                };
            };
        }


    }
}//package view.castleInfo

