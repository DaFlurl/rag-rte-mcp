// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//view.castleInfo.Heros

package view.castleInfo
{
    import mx.containers.Canvas;
    import mx.binding.IBindingClient;
    import mx.binding.IWatcherSetupUtil;
    import mx.controls.Label;
    import mx.controls.Image;
    import com.evony.common.beans.HeroBean;
    import mx.core.UIComponentDescriptor;
    import mx.core.mx_internal;
    import com.evony.util.ImageSmooth;
    import flash.events.Event;
    import mx.events.PropertyChangeEvent;
    import flash.utils.getDefinitionByName;
    import mx.binding.Binding;
    import com.evony.common.constants.HeroConstants;
    import com.evony.factory.ImageManager;
    import com.evony.Lang;
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

    public class Heros extends Canvas implements IBindingClient 
    {

        private static var _watcherSetupUtil:IWatcherSetupUtil;

        private var _807085890myStatus:String;
        private var _2131397820levetTxt:Label;
        public var levColor:String;
        private var _738344555iconFile:Image;
        public var _Heros_Image2:Image;
        private var _1721941989nameTxt:Label;
        private var _2069167065heroObject:HeroBean;
        private var _1916786312imgPath:Object;

        private var _documentDescriptor_:UIComponentDescriptor = new UIComponentDescriptor({
            "type":Canvas,
            "propertiesFactory":function ():Object
            {
                return ({
                    "width":210,
                    "height":32,
                    "childDescriptors":[new UIComponentDescriptor({
                        "type":Image,
                        "id":"iconFile",
                        "events":{"complete":"__iconFile_complete"},
                        "stylesFactory":function ():void
                        {
                            this.left = "5";
                            this.verticalCenter = "0";
                        },
                        "propertiesFactory":function ():Object
                        {
                            return ({
                                "width":30,
                                "height":30
                            });
                        }
                    }), new UIComponentDescriptor({
                        "type":Label,
                        "id":"nameTxt",
                        "stylesFactory":function ():void
                        {
                            this.left = "40";
                            this.verticalCenter = "0";
                        },
                        "propertiesFactory":function ():Object
                        {
                            return ({
                                "height":22,
                                "styleName":"tableContent1",
                                "width":80
                            });
                        }
                    }), new UIComponentDescriptor({
                        "type":Label,
                        "id":"levetTxt",
                        "stylesFactory":function ():void
                        {
                            this.left = "125";
                            this.verticalCenter = "0";
                            this.fontWeight = "bold";
                        },
                        "propertiesFactory":function ():Object
                        {
                            return ({
                                "height":22,
                                "styleName":"tableContent3"
                            });
                        }
                    }), new UIComponentDescriptor({
                        "type":Image,
                        "id":"_Heros_Image2",
                        "events":{"complete":"___Heros_Image2_complete"},
                        "stylesFactory":function ():void
                        {
                            this.verticalCenter = "0";
                            this.right = "5";
                        }
                    })]
                });
            }
        });
        mx_internal var _bindings:Array = [];
        mx_internal var _watchers:Array = [];
        mx_internal var _bindingsByDestination:Object = {};
        mx_internal var _bindingsBeginWithWord:Object = {};

        public function Heros()
        {
            mx_internal::_document = this;
            this.width = 210;
            this.height = 32;
        }

        public static function set watcherSetupUtil(_arg_1:IWatcherSetupUtil):void
        {
            Heros._watcherSetupUtil = _arg_1;
        }


        public function __iconFile_complete(_arg_1:Event):void
        {
            ImageSmooth.onLoadComplete(_arg_1);
        }

        public function set levetTxt(_arg_1:Label):void
        {
            var _local_2:Object = this._2131397820levetTxt;
            if (_local_2 !== _arg_1)
            {
                this._2131397820levetTxt = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "levetTxt", _local_2, _arg_1));
            };
        }

        [Bindable(event="propertyChange")]
        public function get levetTxt():Label
        {
            return (this._2131397820levetTxt);
        }

        [Bindable(event="propertyChange")]
        private function get imgPath():Object
        {
            return (this._1916786312imgPath);
        }

        override public function initialize():void
        {
            var target:Heros;
            var watcherSetupUtilClass:Object;
            (mx_internal::setDocumentDescriptor(_documentDescriptor_));
            var bindings:Array = _Heros_bindingsSetup();
            var watchers:Array = [];
            target = this;
            if (_watcherSetupUtil == null)
            {
                watcherSetupUtilClass = getDefinitionByName("_view_castleInfo_HerosWatcherSetupUtil");
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

        [Bindable(event="propertyChange")]
        public function get iconFile():Image
        {
            return (this._738344555iconFile);
        }

        private function _Heros_bindingExprs():void
        {
            var _local_1:*;
            _local_1 = heroObject.logoUrl;
            _local_1 = heroObject.name;
            _local_1 = heroObject.level;
            _local_1 = this.imgPath;
            _local_1 = this.myStatus;
        }

        private function set imgPath(_arg_1:Object):void
        {
            var _local_2:Object = this._1916786312imgPath;
            if (_local_2 !== _arg_1)
            {
                this._1916786312imgPath = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "imgPath", _local_2, _arg_1));
            };
        }

        [Bindable(event="propertyChange")]
        private function get heroObject():HeroBean
        {
            return (this._2069167065heroObject);
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

        public function ___Heros_Image2_complete(_arg_1:Event):void
        {
            ImageSmooth.onLoadComplete(_arg_1);
        }

        [Bindable(event="propertyChange")]
        public function get nameTxt():Label
        {
            return (this._1721941989nameTxt);
        }

        private function _Heros_bindingsSetup():Array
        {
            var binding:Binding;
            var result:Array = [];
            binding = new Binding(this, function ():Object
            {
                return (heroObject.logoUrl);
            }, function (_arg_1:Object):void
            {
                iconFile.source = _arg_1;
            }, "iconFile.source");
            result[0] = binding;
            binding = new Binding(this, function ():String
            {
                var _local_1:* = heroObject.name;
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                nameTxt.text = _arg_1;
            }, "nameTxt.text");
            result[1] = binding;
            binding = new Binding(this, function ():String
            {
                var _local_1:* = heroObject.level;
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                levetTxt.text = _arg_1;
            }, "levetTxt.text");
            result[2] = binding;
            binding = new Binding(this, function ():Object
            {
                return (this.imgPath);
            }, function (_arg_1:Object):void
            {
                _Heros_Image2.source = _arg_1;
            }, "_Heros_Image2.source");
            result[3] = binding;
            binding = new Binding(this, function ():String
            {
                var _local_1:* = this.myStatus;
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                _Heros_Image2.toolTip = _arg_1;
            }, "_Heros_Image2.toolTip");
            result[4] = binding;
            return (result);
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

        private function set heroObject(_arg_1:HeroBean):void
        {
            var _local_2:Object = this._2069167065heroObject;
            if (_local_2 !== _arg_1)
            {
                this._2069167065heroObject = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "heroObject", _local_2, _arg_1));
            };
        }

        public function set hero(_arg_1:Object):void
        {
            this.heroObject = HeroBean(_arg_1);
            setStatus(this.heroObject.status);
            setLvColor();
        }

        private function setLvColor():void
        {
            if (levColor != "")
            {
                levetTxt.setStyle("color", levColor);
            };
        }

        private function setStatus(_arg_1:int):void
        {
            if (_arg_1 == 8)
            {
                _arg_1 = HeroConstants.HERO_SEND_STATU;
                this.imgPath = ImageManager.getHeroStatusImgMap(_arg_1);
                myStatus = "Farming";
                return;
            };
            this.imgPath = ImageManager.getHeroStatusImgMap(_arg_1);
            switch (_arg_1)
            {
                case HeroConstants.HERO_FREE_STATU:
                    myStatus = Lang.msg("空闲");
                    return;
                case HeroConstants.HERO_CHIEF_STATU:
                    myStatus = Lang.msg("城守");
                    return;
                case HeroConstants.HERO_GUARD_STATU:
                    myStatus = Lang.msg("驻守");
                    return;
                case HeroConstants.HERO_SEND_STATU:
                    myStatus = Lang.msg("出征");
                    return;
                case HeroConstants.HERO_SEIZED_STATU:
                    myStatus = Lang.msg("俘虏");
                    return;
                case HeroConstants.HERO_BACK_STATU:
                    myStatus = Lang.msg("返回");
                    return;
            };
        }

        private function set myStatus(_arg_1:String):void
        {
            var _local_2:Object = this._807085890myStatus;
            if (_local_2 !== _arg_1)
            {
                this._807085890myStatus = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "myStatus", _local_2, _arg_1));
            };
        }

        [Bindable(event="propertyChange")]
        private function get myStatus():String
        {
            return (this._807085890myStatus);
        }


    }
}//package view.castleInfo

