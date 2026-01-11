// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//mx.controls.dataGridClasses.DataGridHeaderBase

package mx.controls.dataGridClasses
{
    import mx.core.UIComponent;
    import flash.display.Sprite;
    import mx.core.mx_internal; 

    use namespace mx_internal;

    public class DataGridHeaderBase extends UIComponent 
    {

        mx_internal var headerItemsChanged:Boolean = false;
        mx_internal var selectionLayer:Sprite;
        mx_internal var visibleColumns:Array;


        mx_internal function clearSelectionLayer():void
        {
        }


    }
}//package mx.controls.dataGridClasses

