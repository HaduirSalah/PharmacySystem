   M S B A M L   `   `   `  ����A  =Design, Version=1.0.0.0, Culture=neutral, PublicKeyToken=nullclr-namespace:DesignDesign  5   	       Design.Return   5      W SPresentationCore, Version=7.0.0.0, Culture=neutral, PublicKeyToken=31bf3856ad364e35\ XPresentationFramework, Version=7.0.0.0, Culture=neutral, PublicKeyToken=31bf3856ad364e35e aSystem.Windows.Controls.Ribbon, Version=7.0.0.0, Culture=neutral, PublicKeyToken=b77a5c561934e089R NWindowsBase, Version=7.0.0.0, Culture=neutral, PublicKeyToken=31bf3856ad364e35F 9http://schemas.microsoft.com/winfx/2006/xaml/presentation     5   	   R NSystem.Xaml, Version=7.0.0.0, Culture=neutral, PublicKeyToken=b77a5c561934e089:x,http://schemas.microsoft.com/winfx/2006/xaml     5   	   @d2http://schemas.microsoft.com/expression/blend/2008     5   	   Jmc;http://schemas.openxmlformats.org/markup-compatibility/2006     5   	   &localclr-namespace:Design     5   	   $	��650��5   
   $	��900��6   
�������.��5      �   � ColumnDefinitions  5   
   �� 5      $��* �6   6+   �� 5      $
��1.4* �6   6.    � RowDefinitions 5   
   �� 5      6   .+�5   
   �� $��0��6   $��0,0,10,0q�6%   .+�5      �� $��0��6   $��40(�6$   
����d�$	��Top=�6N   $��62��6c   $	��221��6o   $��
-77,13,0,0q�6{   $
��Bold"�6�   .��6�   Return6�   � 5      $��
-10,50,0,0q�6   .+�5      �� $��20(�6   $��Medium"�6+   $	��133��6?   $��23,0,0,0q�6K   
����d��� 6|   $�	Bill ID :��6�   6�   �� 5      -   5         ��Name$ BIllIdTB��5      $��20(�6,   $��30��6;   $	��230��6G   $��
95,-26,0,0q�6S   �� 5      -   5        $	��130��5      $��40��6%   
����d�$��20(�6M   $��Medium"�6[   
�������$��-398,-16,-77,-107q�6�   $��ShowDetails��5   A   5      5      � 5       J� RenderTransformOrigin$ 0.5,0.5&�6   $	��352��68   $	��176��6D   z�5      V� 5       .~�5!      �� �� 5"       �� AngleY$ 0Q�6(   �� 5#      T� 5$       T� Y$ 0Q�6-   5%      .+�5)      �� $��3,85,0,0q�6   $	��321��6/   .+�5*      �� $��	-5,12,0,0q�6   $��20(�61   $��Medium"�6?   $��Quantity��6T   
����d�6g   �� 5+      -   5        $ Quantytb��5+   E   $	��201��6   $��30��6+   $��20(�67   
�������$��-6,-36,-111,0q�6l   $ 0.5,0.5&�6�   .��6�   z�5,      V� 5-      .~�5.   "   �� �� 5/   "   �� 50   "   T� 51   "   52      .��53   3   54      55      56      �� 58      -   5        $	��166��58      $��40��6!   
����d�$��20(�6I   $��Medium"�6W   
�������$��0,-222,38,-349q�6�   $��Return��59   8   5:      5;      �� 5=   
   $��2��6   $��	333,0,0,0q�6)   .+�5>      &   System.Windows.Controls.DataGrid  -   5          Name$ BillGrid��5>      $��15(�6*   
���   �$��Medium"�6K   $	��482��6�   $	��426��6�    � 	Resources 5?      =  7System.Windows.Controls.Primitives.DataGridColumnHeader �� 
TargetType	 �� Property
 �� Value��%�   '        �� 5@      "  6   .�5A      �� 	 � ��

 ��d�67   �� 5B      	 � ��$
 0 0 12 0q�63   �� 5C      	 � ��$
 0,0,1,2q�6<   �� 5D      	 � ��

 �����68   5E      5F         Columns 5G      0  *System.Windows.Controls.DataGridTextColumn  5I      ,  &System.Windows.Controls.DataGridColumn   Width5  /System.Windows.Controls.DataGridLengthConverter$	 130 6+      Header$ MedicineName��67   1  +System.Windows.Controls.DataGridBoundColumn   Binding 6M   �� *MedicineName+  5J      $ Quantity��6)   $	 100 6;    6G   �� *
Quantity+  5K      $ 	UnitPrice��6+   $	 120 6>    6J   �� *	UnitPrice+  5L      $ 
TotalPrice��6)   $	 130 6=    6I   �� *
TotalPrice+5O      5P      5Q      5R      