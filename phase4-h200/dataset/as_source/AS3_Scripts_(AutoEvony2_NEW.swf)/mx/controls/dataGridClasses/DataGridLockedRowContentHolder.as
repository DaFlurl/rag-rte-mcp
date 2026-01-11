// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//mx.controls.dataGridClasses.DataGridLockedRowContentHolder

package mx.controls.dataGridClasses
{
    import mx.controls.listClasses.ListBaseContentHolder;
    import mx.controls.listClasses.ListBase;

    public class DataGridLockedRowContentHolder extends ListBaseContentHolder 
    {

        public function DataGridLockedRowContentHolder(_arg_1:ListBase)
        {
            super(_arg_1);
            if (_arg_1.dataProvider)
            {
                iterator = _arg_1.dataProvider.createCursor();
            };
        }

        override public function get measuredHeight():Number
        {
            var _local_1:Number = rowInfo.length;
            if (_local_1 == 0)
            {
                return (0);
            };
            return (rowInfo[(_local_1 - 1)].y + rowInfo[(_local_1 - 1)].height);
        }


    }
}//package mx.controls.dataGridClasses

