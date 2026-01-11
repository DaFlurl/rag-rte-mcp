// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//com.evony.util.DemandPreLoader

package com.evony.util
{
    import flash.events.EventDispatcher;
    import flash.events.ProgressEvent;
    import mx.controls.Alert;
    import mx.events.StyleEvent;
    import mx.styles.StyleManager;
    import flash.events.IEventDispatcher;
    import flash.events.Event;
    import com.evony.common.beans.BuildingBean;
    import com.evony.Context;
    import com.evony.common.beans.CastleBean;
    import com.evony.common.constants.BuildingConstants;
    import flash.net.SharedObject;
    import flash.net.URLLoader;
    import flash.events.IOErrorEvent;
    import flash.net.URLRequest;

    public class DemandPreLoader extends EventDispatcher 
    {

        private var skinLoadCallBack:Function = null;
        private var demandLoaded:Boolean = false;
        private var numLoading:int = 0;


        private function onGuideLoaded(_arg_1:Object):void
        {
            fireCallabck();
        }

        private function onLoaded(_arg_1:Object):void
        {
            numLoading--;
            checkFinishAll();
        }

        public function load():void
        {
            EvonyAnimation.readAniInfo(onAniInfoLoaded);
        }

        private function onSkinProgress(_arg_1:ProgressEvent):void
        {
            if (this.skinLoadCallBack == null)
            {
                if (ResourceLoader.onDemandBackgroundProgressFunc != null)
                {
                    ResourceLoader.onDemandBackgroundProgressFunc("evonySkin.swf", _arg_1.bytesLoaded, _arg_1.bytesTotal);
                };
            }
            else
            {
                if (ResourceLoader.onDemandProgressFunc != null)
                {
                    ResourceLoader.onDemandBackgroundProgressFunc("evonySkin.swf", 100, 100);
                    ResourceLoader.onDemandProgressFunc("evonySkin.swf", _arg_1.bytesLoaded, _arg_1.bytesTotal);
                };
            };
        }

        private function checkFinishAll():void
        {
            if (numLoading <= 0)
            {
                fireCallabck();
            };
        }

        private function fireCallabck():void
        {
            if (skinLoadCallBack != null)
            {
                skinLoadCallBack();
            };
        }

        private function onStyleError(_arg_1:StyleEvent):void
        {
            Alert.show((_arg_1.errorText + "\nLoad style fla/skins/evonySkin.swf failed, please contact for techeninue supporting!"), "Load style failed!");
        }

        private function onAniInfoLoaded():void
        {
            numLoading = 3;
            var _local_1:IEventDispatcher = StyleManager.loadStyleDeclarations(ResourceLoader.getNormalUrl("fla/skins/evonySkin.swf"));
            _local_1.addEventListener(StyleEvent.ERROR, onStyleError);
            _local_1.addEventListener(StyleEvent.PROGRESS, onSkinProgress);
            _local_1.addEventListener(StyleEvent.COMPLETE, onLoaded);
            ResourceLoader.loadResource("fla/dynamic/ui234.swf", "", onLoaded, ResourceLoader.LOAD_BACKGROUND_DEMAND);
            ResourceLoader.loadResource(EvonyAnimation.getAniInfoById(EvonyAnimation.TYPE_TownviewFloorTile).file, "", onLoaded, ResourceLoader.LOAD_BACKGROUND_DEMAND);
            this.dispatchEvent(new Event(Event.COMPLETE));
        }

        public function doTownViewSecondPreLoad():void
        {
            var _local_5:BuildingBean;
            ResourceLoader.loadResource(EvonyAnimation.getAniInfoById(EvonyAnimation.TYPE_TurnTableItem).file, "", null, ResourceLoader.LOAD_BACKGROUND_DEMAND);
            var _local_1:BuildingBean;
            var _local_2:BuildingBean;
            var _local_3:CastleBean = Context.getInstance().getCurCastle();
            var _local_4:* = 0;
            for each (_local_5 in _local_3.buildingsArray)
            {
                if (UIUtil.isInnerBuilding(_local_5.positionId))
                {
                    if (_local_5.positionId == -2)
                    {
                        _local_1 = _local_5;
                    }
                    else
                    {
                        if (_local_5.typeId == BuildingConstants.TYPE_TOWN_HALL)
                        {
                            _local_2 = _local_5;
                        }
                        else
                        {
                            _local_4 = EvonyAnimation.getAniIdFromCityAndTownBuildingType(_local_5.typeId, _local_5.status, _local_5.level, _local_5.appearance);
                            if (EvonyAnimation.getAniInfoById(_local_4) != null)
                            {
                                ResourceLoader.loadResource(EvonyAnimation.getAniInfoById(_local_4).file, "", null, ResourceLoader.LOAD_BACKGROUND_DEMAND);
                            };
                        };
                    };
                };
            };
            _local_4 = EvonyAnimation.getAniIdFromCityAndTownBuildingType(_local_2.typeId, _local_5.status, _local_5.level, _local_5.appearance);
            if (EvonyAnimation.getAniInfoById(_local_4) != null)
            {
                ResourceLoader.loadResource(EvonyAnimation.getAniInfoById(_local_4).file, "", null, ResourceLoader.LOAD_BACKGROUND_DEMAND);
            };
            if (_local_1 == null)
            {
                _local_4 = EvonyAnimation.TYPE_WallCLv1;
            }
            else
            {
                _local_4 = EvonyAnimation.getAniIdFromCityAndTownBuildingType(_local_1.typeId, _local_5.status, _local_5.level, _local_5.appearance);
            };
            if (EvonyAnimation.getAniInfoById(_local_4) != null)
            {
                ResourceLoader.loadResource(EvonyAnimation.getAniInfoById(_local_4).file, "", null, ResourceLoader.LOAD_BACKGROUND_DEMAND);
            };
            var _local_6:SharedObject = SharedObject.getLocal("skipAnimation", "/");
            if (((_local_6.data.value == false) && (!(Context.getInstance().needUserGuide))))
            {
                for each (_local_5 in _local_3.buildingsArray)
                {
                    if (!(((!(UIUtil.isInnerBuilding(_local_5.positionId))) || (_local_5.typeId == BuildingConstants.TYPE_TOWN_HALL)) || (_local_5.positionId == -2)))
                    {
                        _local_4 = EvonyAnimation.getLoginAniIdFromTownBuildingType(_local_5.typeId, _local_5.status, _local_5.level, _local_5.appearance);
                        if (EvonyAnimation.getAniInfoById(_local_4) != null)
                        {
                            ResourceLoader.loadResource(EvonyAnimation.getAniInfoById(_local_4).file, "", null, ResourceLoader.LOAD_BACKGROUND_DEMAND);
                        };
                    };
                };
                _local_4 = EvonyAnimation.getLoginAniIdFromTownBuildingType(_local_2.typeId, _local_5.status, _local_5.level, _local_5.appearance);
                if (EvonyAnimation.getAniInfoById(_local_4) != null)
                {
                    ResourceLoader.loadResource(EvonyAnimation.getAniInfoById(_local_4).file, "", null, ResourceLoader.LOAD_BACKGROUND_DEMAND);
                };
                if (_local_1 == null)
                {
                    _local_4 = EvonyAnimation.TYPE_WallStructCLv1;
                }
                else
                {
                    _local_4 = EvonyAnimation.getLoginAniIdFromTownBuildingType(_local_1.typeId, _local_5.status, _local_5.level, _local_5.appearance);
                };
                if (EvonyAnimation.getAniInfoById(_local_4) != null)
                {
                    ResourceLoader.loadResource(EvonyAnimation.getAniInfoById(_local_4).file, "", null, ResourceLoader.LOAD_BACKGROUND_DEMAND);
                };
            };
        }

        public function forceDemandLoaded(_arg_1:Function):void
        {
            var _local_2:URLLoader;
            if (((EvonyClient.newComer) || (EvonyClient.isTryGame)))
            {
                numLoading = (numLoading + 2);
                ResourceLoader.loadResource("fla/dynamic/guide.swf", "", onLoaded, ResourceLoader.LOAD_BACKGROUND_DEMAND);
                _local_2 = new URLLoader();
                _local_2.addEventListener(Event.COMPLETE, onLoaded);
                _local_2.addEventListener(IOErrorEvent.IO_ERROR, onLoaded);
                _local_2.load(new URLRequest(ResourceLoader.getNormalUrl("fla/guide/Eva01.mp3")));
            };
            if (numLoading == 0)
            {
                (_arg_1());
            }
            else
            {
                this.skinLoadCallBack = _arg_1;
            };
        }


    }
}//package com.evony.util

