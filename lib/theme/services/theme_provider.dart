import 'package:flutter/material.dart';
import 'package:focusappfrontend/theme/app_colors.dart';
import 'package:focusappfrontend/theme/app_gradients.dart';

class ThemeProvider extends ChangeNotifier {
  Color _primaryColor = AppColors.focusPrimaryDefault;
  Color _secondaryColor = AppColors.focusSecondaryDefault;

  Color get primaryColor => _primaryColor;
  Color get secondaryColor => _secondaryColor;

  void updateThemeColor(Color newPrimary, {Color? newSecondary}) {
    _primaryColor = newPrimary;
    // For simplicity, generate a slightly darker/adjusted secondary color if not provided 
    // or just use the same color for the gradient effect
    _secondaryColor = newSecondary ?? newPrimary.withOpacity(0.8);
    
    // Update global static vars so we don't have to rewrite 100% of widgets immediately 
    // if they just access the statics (though rebuilding requires listening).
    AppColors.focusPrimary = _primaryColor;
    AppColors.focusSecondary = _secondaryColor;
    
    AppGradients.updateGradients(_primaryColor, _secondaryColor);
    
    notifyListeners();
  }
}
