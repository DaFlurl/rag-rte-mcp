// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//com.evony.util.MinePopupManager

package com.evony.util
{
    import mx.core.IFlexDisplayObject;
    import flash.display.Sprite;
    import mx.managers.PopUpManager;
    import view.MainWin;
    import view.castle.TownView;
    import view.castle.MainFrame;
    import view.castle.Map;
    import mx.core.Application;
    import mx.core.UIComponent;
    import flash.display.DisplayObject;
    import flash.events.MouseEvent;
    import view.castle.CityView;

    public class MinePopupManager 
    {

        public static var instance:MinePopupManager = new (MinePopupManager)();

        public var curPopupObj:IFlexDisplayObject;
        private var maskSprite:Sprite = new Sprite();


        public function getObj():IFlexDisplayObject
        {
            return (curPopupObj);
        }

        public function removePopup():void
        {
            if (curPopupObj)
            {
                PopUpManager.removePopUp(curPopupObj);
                curPopupObj = null;
                if (((!(MainWin.instance == null)) && (MainWin.instance.skip_btn.visible == false)))
                {
                    if (TownView.singleton().isShow)
                    {
                        TownView.singleton().restorePlayAll();
                    };
                    if (((!(MainFrame.instance.cityView == null)) && (MainFrame.instance.cityView.isShow)))
                    {
                        MainFrame.instance.cityView.restorePlayAll();
                    };
                    if (((!(MainFrame.instance.mapWin == null)) && (MainFrame.instance.mapWin.isShow)))
                    {
                        if (Map.instance != null)
                        {
                            MainFrame.instance.mapWin.restorePlayAll();
                        };
                    };
                };
            };
        }

        private function doCenterPopUp():void
        {
            if (curPopupObj)
            {
                if ((Application.application.width - curPopupObj.width) > 0)
                {
                    curPopupObj.x = (((Application.application.width - curPopupObj.width) / 2) - 150);
                    curPopupObj.y = (((Application.application.height - curPopupObj.height) / 2) - 30);
                    if (((curPopupObj.x < 0) || (curPopupObj.y < 0)))
                    {
                        curPopupObj.x = ((Application.application.width - curPopupObj.width) / 2);
                        curPopupObj.y = ((Application.application.height - curPopupObj.height) / 2);
                    };
                    PopUpManager.bringToFront(curPopupObj);
                }
                else
                {
                    PopUpManager.centerPopUp(curPopupObj);
                };
            };
        }

        public function addPopup(_arg_1:IFlexDisplayObject, _arg_2:DisplayObject, _arg_3:Boolean=false, _arg_4:String=null):void
        {
            if (curPopupObj)
            {
                PopUpManager.removePopUp(curPopupObj);
            };
            UIUtil.setPopopHelpWindowStye(_arg_1);
            if (!UIComponent(_arg_1).isPopUp)
            {
                PopUpManager.addPopUp(_arg_1, _arg_2, _arg_3);
            }
            else
            {
                PopUpManager.bringToFront(_arg_1);
            };
            curPopupObj = _arg_1;
        }

        private function functionNothing(_arg_1:MouseEvent):void
        {
        }

        public function centerPopUp():void
        {
            doCenterPopUp();
            if (((!(MainWin.instance == null)) && (MainWin.instance.skip_btn.visible == false)))
            {
                TownView.singleton().stopPlayAll();
                if (MainFrame.instance.cityView != null)
                {
                    CityView.singleton().stopPlayAll();
                };
                if (MainFrame.instance.mapWin != null)
                {
                    MainFrame.instance.mapWin.stopPlayAll();
                };
            };
        }

        public function bringToFront():void
        {
            PopUpManager.bringToFront(curPopupObj);
        }

        public function onAppResize():void
        {
            if (curPopupObj != null)
            {
                doCenterPopUp();
            };
        }


    }
}//package com.evony.util

