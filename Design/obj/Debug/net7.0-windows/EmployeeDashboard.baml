   M S B A M L   `   `   `  ����A  =Design, Version=1.0.0.0, Culture=neutral, PublicKeyToken=nullclr-namespace:DesignDesign  5   	       Design.EmployeeDashboard   5   	   W SPresentationCore, Version=7.0.0.0, Culture=neutral, PublicKeyToken=31bf3856ad364e35\ XPresentationFramework, Version=7.0.0.0, Culture=neutral, PublicKeyToken=31bf3856ad364e35e aSystem.Windows.Controls.Ribbon, Version=7.0.0.0, Culture=neutral, PublicKeyToken=b77a5c561934e089R NWindowsBase, Version=7.0.0.0, Culture=neutral, PublicKeyToken=31bf3856ad364e35F 9http://schemas.microsoft.com/winfx/2006/xaml/presentation     5   	   R NSystem.Xaml, Version=7.0.0.0, Culture=neutral, PublicKeyToken=b77a5c561934e089:x,http://schemas.microsoft.com/winfx/2006/xaml     5   	   @d2http://schemas.microsoft.com/expression/blend/2008     5   	   Jmc;http://schemas.openxmlformats.org/markup-compatibility/2006     5   	   &localclr-namespace:Design     5   	   -   5        $��window��5	   	     � Title$  	Dashboard��5   	    � Icon$ dashboard.png��5	       � WindowStartupLocation$ CenterScreen=�5
   	    � WindowStyle$
 None=�5   	    � AllowsTransparency$
 True��5   	   ���#ffffff$
��1080��68   $	��720��6E   .��5      (� .��5   
   � $	��660��6   $
��1000��6!   $��	-7,0,-4,0q�6.   .+�5      ��  �� CornerRadius$ 30��6   
����d� �� Padding$ 0,2,0,0q�6C   $	��648��6U   $��12,0,0,0q�6b    J� Effect 5      3  -System.Windows.Media.Effects.DropShadowEffect  5         ShadowDepth$ 1Q�6'   	   
BlurRadius$	 20Q�67   
   Opacity$	
 0.4Q�6G   ._�5      � .+�5      �� $��0,7,0,-7q�6!   .+�5      �� $��Center=�6    
�������6=   �� 5         menueButton#��[  6!   $��0q�6F   $��
17,0,15,20q�6Z   �� 5       $��Center=�6    
�������6=   �� 5!      #��[  6!   $��0q�6F   $��
15,0,15,20q�6Z   �� 5#      $��Center=�6    
�������$
��Bill��6P   �� 5$      -   5        #��[  5$   !   $��0q�6F   $��
15,2,15,34q�6m   .��5%      �� $��	billl.png��6$   $��40��67   5&      �� 5)      $��Center=�6    
�������$��Return-Bill��6P   �� 5*      -   5        #��[  5*   !   $��0q�6F   $��50��6Z   $��50��6e   .��5+      �� $��returnB.png��6$   $��45��69   $��59��6D   5,      �� 54      -   5        #��[  54   !   $��9,173,11,43q�6F   
������ $��0q�6t   $��60��6�   $��51��6�   .��55      �� $��exit.png��6$   $��40��66   $��40��6A   56      59      5:      5<      �� 5?      $��Right=�6   � 5@      �� 5C       � 5D      -   5          �Name$ Controll��5D      $��Center=�6&   $	��650��6C   $	��900��6P   
����d� J� RenderTransformOrigin$ 0.5,0.5&�6x   $��94,-648,0,0q�6�   $��3q�6�   z�5E      V� 5F      .~�5G      �� �� 5H       �� AngleX$ 0Q�6(   �� 5I      T� 5J       T� X$ 0Q�6-   5K      5N      �� 5O      -   5        $��
WelcomeMsg��5O      $��40(�6'   
�������$��Hello��6H   5P      5Q      5S      