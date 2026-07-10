import 'package:flutter/material.dart';

import '../../../../shared/navigation/main_navigation_controller.dart';
import '../../../../shared/widgets/biometric_authentication_view.dart';
import '../../../profile/presentation/widgets/profile_status_tab.dart';
import '../widgets/birth_certificate_application_steps.dart';
import '../widgets/service_application_common_widgets.dart';
import '../widgets/service_application_scaffold.dart';

class BirthCertificateApplicationPage extends StatefulWidget {
  final bool isLoggedIn;
  final VoidCallback? onMenuTap;
  final VoidCallback? onLoginTap;

  const BirthCertificateApplicationPage({
    super.key,
    this.isLoggedIn = false,
    this.onMenuTap,
    this.onLoginTap,
  });

  @override
  State<BirthCertificateApplicationPage> createState() {
    return _BirthCertificateApplicationPageState();
  }
}

class _BirthCertificateApplicationPageState
    extends State<BirthCertificateApplicationPage> {
  static const int _totalSteps = 5;

  final TextEditingController _childNameController = TextEditingController(
    text: 'Rizkiawan Andrawan',
  );

  final TextEditingController _childOrderController = TextEditingController(
    text: '2',
  );

  final TextEditingController _birthPlaceController = TextEditingController(
    text: 'DKI Jakarta',
  );

  final TextEditingController _birthDateController = TextEditingController(
    text: 'Senin, 18 Feb 2026',
  );

  final TextEditingController _birthTimeController = TextEditingController(
    text: '12.00 WIB',
  );

  final TextEditingController _birthWeightController = TextEditingController(
    text: '3.85',
  );

  final TextEditingController _birthLengthController = TextEditingController(
    text: '40',
  );

  int _currentStep = 0;

  bool _isFamilyCardVerified = false;
  final bool _isMarriageCertificateVerified = true;
  final bool _isBirthLetterVerified = true;

  bool _isFatherVerified = true;
  bool _isMotherVerified = false;

  bool _isFirstWitnessVerified = false;
  bool _isSecondWitnessVerified = false;

  bool _isTermsAccepted = false;

  String _selectedGender = 'Laki-laki';
  final String _selectedBirthType = 'Tunggal';
  final String _selectedBirthPlaceType = 'Rumah Sakit / Rumah Bersalin';

  final List<String> _selectedBirthAssistants = [
    'Dokter',
    'Bidan',
  ];

  bool get _isSuccess {
    return _currentStep >= _totalSteps;
  }

  String get _stepTitle {
    switch (_currentStep) {
      case 0:
        return 'Validasi Dokumen';
      case 1:
        return 'Data Orang Tua';
      case 2:
        return 'Data Anak';
      case 3:
        return 'Data Saksi';
      case 4:
        return 'Ringkasan';
      default:
        return '';
    }
  }

  void _handleBack() {
    if (_isSuccess) {
      Navigator.of(context).pop(true);
      return;
    }

    if (_currentStep > 0) {
      _previousStep();
      return;
    }

    Navigator.of(context).pop(false);
  }

  void _nextStep() {
    if (!_validateCurrentStep()) {
      return;
    }

    if (_currentStep >= _totalSteps - 1) {
      return;
    }

    setState(() {
      _currentStep++;
    });
  }

  void _previousStep() {
    if (_currentStep <= 0) {
      return;
    }

    setState(() {
      _currentStep--;
    });
  }

  void _submitApplication() {
    if (!_validateCurrentStep()) {
      return;
    }

    ProfileStatusStore.addBirthCertificateSubmission();

    setState(() {
      _currentStep = _totalSteps;
    });
  }

  void _openStatusPage() {
    MainNavigationController.instance.goProfileStatus();
  }

  void _cancelApplication() {
    Navigator.of(context).pop(false);
  }

  void _returnToService() {
    MainNavigationController.instance.goServices();
  }

  void _changeGender(String value) {
    setState(() {
      _selectedGender = value;
    });
  }

  void _changeTermsAccepted(bool value) {
    setState(() {
      _isTermsAccepted = value;
    });
  }

  Future<void> _openQrVerification({
    required VoidCallback onVerified,
  }) async {
    await showDialog<void>(
      context: context,
      builder: (_) {
        return const ServiceApplicationQrDialog();
      },
    );

    if (!mounted) {
      return;
    }

    setState(onVerified);
  }

  bool _validateCurrentStep() {
    if (_currentStep == 0) {
      final allDocumentsVerified = _isFamilyCardVerified &&
          _isMarriageCertificateVerified &&
          _isBirthLetterVerified;

      if (!allDocumentsVerified) {
        _showMessage('Pastikan semua dokumen sudah terverifikasi.');
        return false;
      }
    }

    if (_currentStep == 1) {
      if (!_isFatherVerified || !_isMotherVerified) {
        _showMessage('Pastikan data ayah dan ibu sudah terverifikasi.');
        return false;
      }
    }

    if (_currentStep == 2) {
      if (_childNameController.text.trim().isEmpty ||
          _childOrderController.text.trim().isEmpty) {
        _showMessage('Lengkapi data anak terlebih dahulu.');
        return false;
      }
    }

    if (_currentStep == 3) {
      if (!_isFirstWitnessVerified || !_isSecondWitnessVerified) {
        _showMessage('Pastikan kedua saksi sudah terverifikasi.');
        return false;
      }
    }

    if (_currentStep == 4) {
      if (!_isTermsAccepted) {
        _showMessage('Setujui syarat dan ketentuan terlebih dahulu.');
        return false;
      }
    }

    return true;
  }

  void _showMessage(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        behavior: SnackBarBehavior.floating,
      ),
    );
  }

  Future<void> _openBiometricAuthentication() async {
    final isAuthenticated = await Navigator.of(context).push<bool>(
      MaterialPageRoute(
        builder: (_) => const BiometricAuthenticationView(
          title: 'Verifikasi Wajah',
          description:
          'Ambil gambar wajah Anda untuk menyatakan persetujuan.',
          instruction: 'Pastikan wajah Anda terlihat jelas.',
          buttonLabel: 'Tutup',
          faceImageAsset: 'assets/images/birth_certificate_face_scan.jpg',
        ),
      ),
    );

    if (!mounted || isAuthenticated != true) {
      return;
    }

    _submitApplication();
  }

  Widget _buildCurrentStep() {
    if (_isSuccess) {
      return ServiceApplicationSuccessView(
        title: 'Pengajuan Data Berhasil',
        description:
        'Cek status pengajuan Anda di halaman Status atau kembali ke halaman Layanan.',
        onStatusPressed: _openStatusPage,
        onReturnPressed: _returnToService,
      );
    }

    switch (_currentStep) {
      case 0:
        return BirthCertificateDocumentStep(
          isFamilyCardVerified: _isFamilyCardVerified,
          isMarriageCertificateVerified: _isMarriageCertificateVerified,
          isBirthLetterVerified: _isBirthLetterVerified,
          onFamilyCardVerifyTap: () {
            _openQrVerification(
              onVerified: () {
                _isFamilyCardVerified = true;
              },
            );
          },
          onNext: _nextStep,
          onCancel: _cancelApplication,
        );

      case 1:
        return BirthCertificateParentValidationStep(
          isFatherVerified: _isFatherVerified,
          isMotherVerified: _isMotherVerified,
          onFatherVerifyTap: () {
            _openQrVerification(
              onVerified: () {
                _isFatherVerified = true;
              },
            );
          },
          onMotherVerifyTap: () {
            _openQrVerification(
              onVerified: () {
                _isMotherVerified = true;
              },
            );
          },
          onNext: _nextStep,
          onPrevious: _previousStep,
          onCancel: _cancelApplication,
        );

      case 2:
        return BirthCertificateBirthDataStep(
          childNameController: _childNameController,
          childOrderController: _childOrderController,
          birthPlaceController: _birthPlaceController,
          birthDateController: _birthDateController,
          birthTimeController: _birthTimeController,
          birthWeightController: _birthWeightController,
          birthLengthController: _birthLengthController,
          selectedGender: _selectedGender,
          selectedBirthType: _selectedBirthType,
          selectedBirthPlaceType: _selectedBirthPlaceType,
          selectedBirthAssistants: _selectedBirthAssistants,
          onGenderChanged: _changeGender,
          onNext: _nextStep,
          onPrevious: _previousStep,
          onCancel: _cancelApplication,
        );

      case 3:
        return BirthCertificateWitnessStep(
          isFirstWitnessVerified: _isFirstWitnessVerified,
          isSecondWitnessVerified: _isSecondWitnessVerified,
          onFirstWitnessVerifyTap: () {
            _openQrVerification(
              onVerified: () {
                _isFirstWitnessVerified = true;
              },
            );
          },
          onSecondWitnessVerifyTap: () {
            _openQrVerification(
              onVerified: () {
                _isSecondWitnessVerified = true;
              },
            );
          },
          onNext: _nextStep,
          onPrevious: _previousStep,
          onCancel: _cancelApplication,
        );

      case 4:
        return BirthCertificateSummaryStep(
          childName: _childNameController.text,
          gender: _selectedGender,
          birthDate: _birthDateController.text,
          birthTime: _birthTimeController.text,
          birthPlace: _birthPlaceController.text,
          birthType: _selectedBirthType,
          birthWeight: _birthWeightController.text,
          birthLength: _birthLengthController.text,
          isTermsAccepted: _isTermsAccepted,
          onTermsChanged: _changeTermsAccepted,
          onSubmit: _openBiometricAuthentication,
          onPrevious: _previousStep,
          onCancel: _cancelApplication,
        );

      default:
        return const SizedBox.shrink();
    }
  }

  @override
  void dispose() {
    _childNameController.dispose();
    _childOrderController.dispose();
    _birthPlaceController.dispose();
    _birthDateController.dispose();
    _birthTimeController.dispose();
    _birthWeightController.dispose();
    _birthLengthController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final safeCurrentStep = _isSuccess ? _totalSteps - 1 : _currentStep;

    return ServiceApplicationScaffold(
      title: 'Penerbitan Akta Kelahiran',
      description:
      'Lengkapi beberapa informasi berikut untuk mengurus akta kelahiran.',
      currentStep: safeCurrentStep,
      totalSteps: _totalSteps,
      stepTitle: _stepTitle,
      isLoggedIn: widget.isLoggedIn,
      showProgress: !_isSuccess,
      contentKey: _isSuccess ? 'success' : _currentStep,
      onMenuTap: widget.onMenuTap,
      onLoginTap: widget.onLoginTap,
      onBack: _handleBack,
      content: _buildCurrentStep(),
    );
  }
}