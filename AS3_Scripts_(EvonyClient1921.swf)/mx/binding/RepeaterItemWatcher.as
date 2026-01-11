// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//mx.binding.RepeaterItemWatcher

package mx.binding
{
    import mx.collections.ICollectionView;
    import mx.events.CollectionEvent;
    import mx.collections.IViewCursor;
    import mx.collections.CursorBookmark;
    import mx.core.mx_internal; 

    use namespace mx_internal;

    public class RepeaterItemWatcher extends Watcher 
    {

        mx_internal static const VERSION:String = "3.5.0.12683";

        private var original:Boolean = true;
        private var clones:Array;
        private var dataProviderWatcher:PropertyWatcher;

        public function RepeaterItemWatcher(_arg_1:PropertyWatcher)
        {
            this.dataProviderWatcher = _arg_1;
        }

        override protected function shallowClone():Watcher
        {
            return (new RepeaterItemWatcher(dataProviderWatcher));
        }

        override public function updateParent(parent:Object):void
        {
            var dataProvider:ICollectionView;
            if (dataProviderWatcher)
            {
                dataProvider = ICollectionView(dataProviderWatcher.value);
                if (dataProvider != null)
                {
                    dataProvider.removeEventListener(CollectionEvent.COLLECTION_CHANGE, changedHandler, false);
                };
            };
            dataProviderWatcher = PropertyWatcher(parent);
            dataProvider = ICollectionView(dataProviderWatcher.value);
            if (dataProvider)
            {
                if (original)
                {
                    dataProvider.addEventListener(CollectionEvent.COLLECTION_CHANGE, changedHandler, false, 0, true);
                    updateClones(dataProvider);
                }
                else
                {
                    wrapUpdate(function ():void
                    {
                        var _local_1:IViewCursor = dataProvider.createCursor();
                        _local_1.seek(CursorBookmark.FIRST, cloneIndex);
                        value = _local_1.current;
                        updateChildren();
                    });
                };
            };
        }

        private function changedHandler(_arg_1:CollectionEvent):void
        {
            var _local_2:ICollectionView = ICollectionView(dataProviderWatcher.value);
            if (_local_2)
            {
                updateClones(_local_2);
            };
        }

        private function updateClones(_arg_1:ICollectionView):void
        {
            var _local_3:RepeaterItemWatcher;
            if (clones)
            {
                clones = clones.splice(0, _arg_1.length);
            }
            else
            {
                clones = [];
            };
            var _local_2:int;
            while (_local_2 < _arg_1.length)
            {
                _local_3 = RepeaterItemWatcher(clones[_local_2]);
                if (!_local_3)
                {
                    _local_3 = RepeaterItemWatcher(deepClone(_local_2));
                    _local_3.original = false;
                    clones[_local_2] = _local_3;
                };
                _local_3.updateParent(dataProviderWatcher);
                _local_2++;
            };
        }


    }
}//package mx.binding

