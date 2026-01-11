// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//mx.controls.Image

package mx.controls
{
    import mx.core.IDataRenderer;
    import mx.controls.listClasses.IDropInListItemRenderer;
    import mx.controls.listClasses.IListItemRenderer;
    import mx.controls.listClasses.BaseListData;
    import flash.display.DisplayObject;
    import flash.events.Event;
    import mx.events.FlexEvent;
    import mx.core.mx_internal; 

    use namespace mx_internal;

    public class Image extends SWFLoader implements IDataRenderer, IDropInListItemRenderer, IListItemRenderer 
    {

        mx_internal static const VERSION:String = "3.6.0.21751";

        private var _listData:BaseListData;
        private var sourceSet:Boolean;
        private var _data:Object;
        private var settingBrokenImage:Boolean;
        private var makeContentVisible:Boolean = false;

        public function Image()
        {
            tabChildren = false;
            tabEnabled = true;
            showInAutomationHierarchy = true;
        }

        override mx_internal function contentLoaderInfo_completeEventHandler(_arg_1:Event):void
        {
            var _local_2:DisplayObject = DisplayObject(_arg_1.target.loader);
            super.contentLoaderInfo_completeEventHandler(_arg_1);
            _local_2.visible = false;
            makeContentVisible = true;
            invalidateDisplayList();
        }

        [Bindable("dataChange")]
        public function get listData():BaseListData
        {
            return (_listData);
        }

        public function set listData(_arg_1:BaseListData):void
        {
            _listData = _arg_1;
        }

        [Bindable("dataChange")]
        public function get data():Object
        {
            return (_data);
        }

        public function set data(_arg_1:Object):void
        {
            _data = _arg_1;
            if (!sourceSet)
            {
                source = ((listData) ? listData.label : data);
                sourceSet = false;
            };
            dispatchEvent(new FlexEvent(FlexEvent.DATA_CHANGE));
        }

        override public function invalidateSize():void
        {
            if (((data) && (settingBrokenImage)))
            {
                return;
            };
            super.invalidateSize();
        }

        [Bindable("sourceChanged")]
        override public function set source(_arg_1:Object):void
        {
            settingBrokenImage = (_arg_1 == getStyle("brokenImageSkin"));
            sourceSet = (!(settingBrokenImage));
            super.source = _arg_1;
        }

        override protected function updateDisplayList(_arg_1:Number, _arg_2:Number):void
        {
            super.updateDisplayList(_arg_1, _arg_2);
            if (((makeContentVisible) && (contentHolder)))
            {
                contentHolder.visible = true;
                makeContentVisible = false;
            };
        }


    }
}//package mx.controls

