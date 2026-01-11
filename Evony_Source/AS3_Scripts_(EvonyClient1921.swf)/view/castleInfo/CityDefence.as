// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//view.castleInfo.CityDefence

package view.castleInfo
{
    import mx.containers.Canvas;
    import mx.binding.IBindingClient;
    import mx.binding.IWatcherSetupUtil;
    import mx.controls.Label;
    import mx.controls.Image;
    import mx.core.UIComponentDescriptor;
    import mx.core.mx_internal;
    import com.evony.util.ImageSmooth;
    import mx.events.FlexEvent;
    import mx.events.PropertyChangeEvent;
    import flash.utils.getDefinitionByName;
    import mx.binding.Binding;
    import com.evony.factory.ImageManager;
    import com.evony.eum.FortificationEumDefine;
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

    public class CityDefence extends Canvas implements IBindingClient 
    {

        private static var _watcherSetupUtil:IWatcherSetupUtil;

        private var _571792071_defenceTpye:String;
        private var _1411693580_defenceId:int;
        private var _1721941989nameTxt:Label;
        private var _1034376950numTxt:Label;
        private var _19956407_imgPath:Object;
        private var _1480346608_count:int;
        private var _738344555iconFile:Image;

        private var _documentDescriptor_:UIComponentDescriptor = new UIComponentDescriptor({
            "type":Canvas,
            "propertiesFactory":function ():Object
            {
                return ({
                    "width":220,
                    "height":37,
                    "childDescriptors":[new UIComponentDescriptor({
                        "type":Image,
                        "id":"iconFile",
                        "events":{"creationComplete":"__iconFile_creationComplete"},
                        "stylesFactory":function ():void
                        {
                            this.verticalCenter = "0";
                            this.left = "5";
                        }
                    }), new UIComponentDescriptor({
                        "type":Label,
                        "id":"numTxt",
                        "stylesFactory":function ():void
                        {
                            this.textAlign = "center";
                            this.fontWeight = "bold";
                            this.verticalCenter = "6";
                            this.left = "60";
                        },
                        "propertiesFactory":function ():Object
                        {
                            return ({"styleName":"commonGoodColor"});
                        }
                    }), new UIComponentDescriptor({
                        "type":Label,
                        "id":"nameTxt",
                        "stylesFactory":function ():void
                        {
                            this.left = "60";
                            this.top = "1";
                            this.textAlign = "center";
                        },
                        "propertiesFactory":function ():Object
                        {
                            return ({"styleName":"commonNormalColor"});
                        }
                    })]
                });
            }
        });
        mx_internal var _bindings:Array = [];
        mx_internal var _watchers:Array = [];
        mx_internal var _bindingsByDestination:Object = {};
        mx_internal var _bindingsBeginWithWord:Object = {};

        public function CityDefence()
        {
            mx_internal::_document = this;
            this.width = 220;
            this.height = 37;
        }

        public static function set watcherSetupUtil(_arg_1:IWatcherSetupUtil):void
        {
            CityDefence._watcherSetupUtil = _arg_1;
        }


        public function __iconFile_creationComplete(_arg_1:FlexEvent):void
        {
            ImageSmooth.onCreationComplete(_arg_1);
        }

        private function set _defenceTpye(_arg_1:String):void
        {
            var _local_2:Object = this._571792071_defenceTpye;
            if (_local_2 !== _arg_1)
            {
                this._571792071_defenceTpye = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "_defenceTpye", _local_2, _arg_1));
            };
        }

        [Bindable(event="propertyChange")]
        private function get _count():int
        {
            return (this._1480346608_count);
        }

        override public function initialize():void
        {
            var target:CityDefence;
            var watcherSetupUtilClass:Object;
            (mx_internal::setDocumentDescriptor(_documentDescriptor_));
            var bindings:Array = _CityDefence_bindingsSetup();
            var watchers:Array = [];
            target = this;
            if (_watcherSetupUtil == null)
            {
                watcherSetupUtilClass = getDefinitionByName("_view_castleInfo_CityDefenceWatcherSetupUtil");
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

        public function set nameTxt(_arg_1:Label):void
        {
            var _local_2:Object = this._1721941989nameTxt;
            if (_local_2 !== _arg_1)
            {
                this._1721941989nameTxt = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "nameTxt", _local_2, _arg_1));
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

        [Bindable(event="propertyChange")]
        private function get _defenceId():int
        {
            return (this._1411693580_defenceId);
        }

        [Bindable(event="propertyChange")]
        public function get iconFile():Image
        {
            return (this._738344555iconFile);
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

        private function set _defenceId(_arg_1:int):void
        {
            var _local_2:Object = this._1411693580_defenceId;
            if (_local_2 !== _arg_1)
            {
                this._1411693580_defenceId = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "_defenceId", _local_2, _arg_1));
            };
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

        [Bindable(event="propertyChange")]
        private function get _imgPath():Object
        {
            return (this._19956407_imgPath);
        }

        public function set defenceId(_arg_1:int):void
        {
            this._defenceId = _arg_1;
            this._imgPath = ImageManager.getFortSmallLogo(_arg_1);
            this._defenceTpye = FortificationEumDefine.getFortificationEumByType(_arg_1).name;
        }

        public function set iconFile(_arg_1:Image):void
        {
            var _local_2:Object = this._738344555iconFile;
            if (_local_2 !== _arg_1)
            {
                this._738344555iconFile = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "iconFile", _local_2, _arg_1));
            };
        }

        private function _CityDefence_bindingsSetup():Array
        {
            var binding:Binding;
            var result:Array = [];
            binding = new Binding(this, function ():Object
            {
                return (this._imgPath);
            }, function (_arg_1:Object):void
            {
                iconFile.source = _arg_1;
            }, "iconFile.source");
            result[0] = binding;
            binding = new Binding(this, function ():String
            {
                var _local_1:* = this._defenceTpye;
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                iconFile.toolTip = _arg_1;
            }, "iconFile.toolTip");
            result[1] = binding;
            binding = new Binding(this, function ():String
            {
                var _local_1:* = this._count;
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                numTxt.text = _arg_1;
            }, "numTxt.text");
            result[2] = binding;
            binding = new Binding(this, function ():String
            {
                var _local_1:* = this._defenceTpye;
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                nameTxt.text = _arg_1;
            }, "nameTxt.text");
            result[3] = binding;
            return (result);
        }

        private function _CityDefence_bindingExprs():void
        {
            var _local_1:*;
            _local_1 = this._imgPath;
            _local_1 = this._defenceTpye;
            _local_1 = this._count;
            _local_1 = this._defenceTpye;
        }

        [Bindable(event="propertyChange")]
        private function get _defenceTpye():String
        {
            return (this._571792071_defenceTpye);
        }

        [Bindable(event="propertyChange")]
        public function get nameTxt():Label
        {
            return (this._1721941989nameTxt);
        }


    }
}//package view.castleInfo

