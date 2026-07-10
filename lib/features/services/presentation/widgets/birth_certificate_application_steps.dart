import 'package:flutter/material.dart';
import 'service_application_common_widgets.dart';

class BirthCertificateDocumentStep extends StatelessWidget {
  final bool isFamilyCardVerified;
  final bool isMarriageCertificateVerified;
  final bool isBirthLetterVerified;
  final VoidCallback onFamilyCardVerifyTap;
  final VoidCallback onNext;
  final VoidCallback onCancel;

  const BirthCertificateDocumentStep({
    super.key,
    required this.isFamilyCardVerified,
    required this.isMarriageCertificateVerified,
    required this.isBirthLetterVerified,
    required this.onFamilyCardVerifyTap,
    required this.onNext,
    required this.onCancel,
  });

  bool get _canContinue {
    return isFamilyCardVerified &&
        isMarriageCertificateVerified &&
        isBirthLetterVerified;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        const ServiceApplicationInformationBanner(
          richMessage: TextSpan(
            children: [
              TextSpan(
                text: 'Pastikan semua dokumen bertanda ',
              ),
              TextSpan(
                text: 'Terverifikasi',
                style: TextStyle(
                  fontWeight: FontWeight.w700,
                ),
              ),
              TextSpan(
                text: ' untuk melanjutkan proses.',
              ),
            ],
          ),
        ),
        const SizedBox(height: 18),
        ServiceApplicationDocumentValidationCard(
          title: 'Kartu Keluarga',
          category: 'Kependudukan',
          documentNumber:
          isFamilyCardVerified ? '317***********01' : 'Belum tersedia',
          isVerified: isFamilyCardVerified,
          onVerifyTap: onFamilyCardVerifyTap,
        ),
        const SizedBox(height: 12),
        ServiceApplicationDocumentValidationCard(
          title: 'Akta Perkawinan',
          category: 'Lainnya',
          documentNumber: 'AK-5**-0******97',
          isVerified: isMarriageCertificateVerified,
        ),
        const SizedBox(height: 12),
        ServiceApplicationDocumentValidationCard(
          title: 'Surat Keterangan Lahir',
          category: 'Kesehatan',
          documentNumber: '331/RSU/SKL/IV/2026',
          isVerified: isBirthLetterVerified,
        ),
        const SizedBox(height: 18),
        ServiceApplicationActions(
          primaryLabel: 'Selanjutnya',
          onPrimaryPressed: _canContinue ? onNext : null,
          onSecondaryPressed: null,
          onCancelPressed: onCancel,
        ),
      ],
    );
  }
}

class BirthCertificateParentValidationStep extends StatelessWidget {
  final bool isFatherVerified;
  final bool isMotherVerified;
  final VoidCallback onFatherVerifyTap;
  final VoidCallback onMotherVerifyTap;
  final VoidCallback onNext;
  final VoidCallback onPrevious;
  final VoidCallback onCancel;

  const BirthCertificateParentValidationStep({
    super.key,
    required this.isFatherVerified,
    required this.isMotherVerified,
    required this.onFatherVerifyTap,
    required this.onMotherVerifyTap,
    required this.onNext,
    required this.onPrevious,
    required this.onCancel,
  });

  bool get _canContinue {
    return isFatherVerified && isMotherVerified;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        const ServiceApplicationInformationBanner(
          message:
          'Scan QR pada aplikasi IKD masing-masing orang tua untuk verifikasi identitas.',
        ),
        const SizedBox(height: 18),
        ServiceApplicationPersonVerificationSection(
          title: 'Data Ayah',
          isVerified: isFatherVerified,
          name: 'Ahmad Andrawan',
          job: 'Karyawan Swasta',
          onVerifyTap: onFatherVerifyTap,
        ),
        const SizedBox(height: 22),
        ServiceApplicationPersonVerificationSection(
          title: 'Data Ibu',
          isVerified: isMotherVerified,
          name: 'Idham Arhadian',
          job: 'Dokter',
          onVerifyTap: onMotherVerifyTap,
        ),
        const SizedBox(height: 18),
        ServiceApplicationActions(
          primaryLabel: 'Selanjutnya',
          onPrimaryPressed: _canContinue ? onNext : null,
          onSecondaryPressed: onPrevious,
          onCancelPressed: onCancel,
        ),
      ],
    );
  }
}

class BirthCertificateBirthDataStep extends StatelessWidget {
  final TextEditingController childNameController;
  final TextEditingController childOrderController;
  final TextEditingController birthPlaceController;
  final TextEditingController birthDateController;
  final TextEditingController birthTimeController;
  final TextEditingController birthWeightController;
  final TextEditingController birthLengthController;

  final String selectedGender;
  final String selectedBirthType;
  final String selectedBirthPlaceType;
  final List<String> selectedBirthAssistants;

  final ValueChanged<String> onGenderChanged;
  final VoidCallback onNext;
  final VoidCallback onPrevious;
  final VoidCallback onCancel;

  const BirthCertificateBirthDataStep({
    super.key,
    required this.childNameController,
    required this.childOrderController,
    required this.birthPlaceController,
    required this.birthDateController,
    required this.birthTimeController,
    required this.birthWeightController,
    required this.birthLengthController,
    required this.selectedGender,
    required this.selectedBirthType,
    required this.selectedBirthPlaceType,
    required this.selectedBirthAssistants,
    required this.onGenderChanged,
    required this.onNext,
    required this.onPrevious,
    required this.onCancel,
  });

  @override
  Widget build(BuildContext context) {
    final birthDateTime =
        '${birthDateController.text} - ${birthTimeController.text}';

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        const ServiceApplicationSubsectionTitle(
          title: 'Identitas Anak',
        ),
        const SizedBox(height: 15),
        ServiceApplicationLabeledTextField(
          label: 'Nama Lengkap',
          requiredField: true,
          controller: childNameController,
        ),
        const SizedBox(height: 14),
        ServiceApplicationDropdownField<String>(
          label: 'Jenis Kelamin',
          requiredField: true,
          value: selectedGender,
          items: const [
            DropdownMenuItem(
              value: 'Laki-laki',
              child: Text('Laki-Laki'),
            ),
            DropdownMenuItem(
              value: 'Perempuan',
              child: Text('Perempuan'),
            ),
          ],
          onChanged: (value) {
            if (value != null) {
              onGenderChanged(value);
            }
          },
        ),
        const SizedBox(height: 14),
        ServiceApplicationLabeledTextField(
          label: 'Anak Ke',
          requiredField: true,
          controller: childOrderController,
          keyboardType: TextInputType.number,
        ),
        const SizedBox(height: 22),
        ServiceApplicationSummaryGroup(
          title: 'Data Kelahiran',
          rows: [
            ServiceApplicationSummaryData(
              label: 'Hari, Tanggal & Waktu Lahir',
              value: birthDateTime,
            ),
            ServiceApplicationSummaryData(
              label: 'Tempat Kelahiran',
              value: birthPlaceController.text,
            ),
            ServiceApplicationSummaryData(
              label: 'Tempat Dilahirkan',
              value: selectedBirthPlaceType,
            ),
            const ServiceApplicationSummaryData(
              label: 'Catatan Medis',
              value: '',
              isSectionTitle: true,
            ),
            ServiceApplicationSummaryData(
              label: 'Jenis Kelahiran',
              value: selectedBirthType,
            ),
            ServiceApplicationSummaryData(
              label: 'Penolong Kelahiran',
              value: selectedBirthAssistants.join(', '),
            ),
            ServiceApplicationSummaryData(
              label: 'Berat & Panjang Badan',
              value:
              '${birthWeightController.text} kg / ${birthLengthController.text} cm',
            ),
          ],
        ),
        const SizedBox(height: 18),
        ServiceApplicationActions(
          primaryLabel: 'Selanjutnya',
          onPrimaryPressed: onNext,
          onSecondaryPressed: onPrevious,
          onCancelPressed: onCancel,
        ),
      ],
    );
  }
}

class BirthCertificateWitnessStep extends StatelessWidget {
  final bool isFirstWitnessVerified;
  final bool isSecondWitnessVerified;
  final VoidCallback onFirstWitnessVerifyTap;
  final VoidCallback onSecondWitnessVerifyTap;
  final VoidCallback onNext;
  final VoidCallback onPrevious;
  final VoidCallback onCancel;

  const BirthCertificateWitnessStep({
    super.key,
    required this.isFirstWitnessVerified,
    required this.isSecondWitnessVerified,
    required this.onFirstWitnessVerifyTap,
    required this.onSecondWitnessVerifyTap,
    required this.onNext,
    required this.onPrevious,
    required this.onCancel,
  });

  bool get _canContinue {
    return isFirstWitnessVerified && isSecondWitnessVerified;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        const ServiceApplicationInformationBanner(
          message:
          'Scan QR pada aplikasi IKD masing-masing saksi untuk verifikasi identitas.',
        ),
        const SizedBox(height: 18),
        ServiceApplicationPersonVerificationSection(
          title: 'Saksi Pertama',
          isVerified: isFirstWitnessVerified,
          name: 'Idham Arhadian',
          job: 'Dokter',
          onVerifyTap: onFirstWitnessVerifyTap,
        ),
        const SizedBox(height: 22),
        ServiceApplicationPersonVerificationSection(
          title: 'Saksi Kedua',
          isVerified: isSecondWitnessVerified,
          name: 'Idham Arhadian',
          job: 'Dokter',
          onVerifyTap: onSecondWitnessVerifyTap,
        ),
        const SizedBox(height: 18),
        ServiceApplicationActions(
          primaryLabel: 'Selanjutnya',
          onPrimaryPressed: _canContinue ? onNext : null,
          onSecondaryPressed: onPrevious,
          onCancelPressed: onCancel,
        ),
      ],
    );
  }
}

class BirthCertificateSummaryStep extends StatelessWidget {
  final String childName;
  final String gender;
  final String birthDate;
  final String birthTime;
  final String birthPlace;
  final String birthType;
  final String birthWeight;
  final String birthLength;
  final bool isTermsAccepted;
  final ValueChanged<bool> onTermsChanged;
  final VoidCallback onSubmit;
  final VoidCallback onPrevious;
  final VoidCallback onCancel;

  const BirthCertificateSummaryStep({
    super.key,
    required this.childName,
    required this.gender,
    required this.birthDate,
    required this.birthTime,
    required this.birthPlace,
    required this.birthType,
    required this.birthWeight,
    required this.birthLength,
    required this.isTermsAccepted,
    required this.onTermsChanged,
    required this.onSubmit,
    required this.onPrevious,
    required this.onCancel,
  });

  @override
  Widget build(BuildContext context) {
    final birthDateTime = '$birthDate - $birthTime';

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        const ServiceApplicationInformationBanner(
          message: 'Pastikan semua data sudah benar untuk melanjutkan proses.',
        ),
        const SizedBox(height: 18),
        const ServiceApplicationSubsectionTitle(
          title: 'Data Orang Tua',
        ),
        const SizedBox(height: 12),
        const ServiceApplicationSummaryGroup(
          title: 'Ayah',
          rows: [
            ServiceApplicationSummaryData(
              label: 'Nama',
              value: 'Ahmad Andrawan',
            ),
            ServiceApplicationSummaryData(
              label: 'Pekerjaan',
              value: 'Karyawan Swasta',
            ),
          ],
        ),
        const SizedBox(height: 12),
        const ServiceApplicationSummaryGroup(
          title: 'Ibu',
          rows: [
            ServiceApplicationSummaryData(
              label: 'Nama',
              value: 'Karlina Maheira',
            ),
            ServiceApplicationSummaryData(
              label: 'Pekerjaan',
              value: 'Ibu Rumah Tangga',
            ),
          ],
        ),
        const SizedBox(height: 18),
        const ServiceApplicationSubsectionTitle(
          title: 'Data Anak',
        ),
        const SizedBox(height: 12),
        ServiceApplicationSummaryGroup(
          title: 'Identitas Anak',
          rows: [
            ServiceApplicationSummaryData(
              label: 'Nama',
              value: childName,
            ),
            ServiceApplicationSummaryData(
              label: 'Jenis Kelamin',
              value: gender,
            ),
            const ServiceApplicationSummaryData(
              label: 'Anak Ke',
              value: '2',
            ),
          ],
        ),
        const SizedBox(height: 12),
        ServiceApplicationSummaryGroup(
          title: 'Data Kelahiran',
          rows: [
            ServiceApplicationSummaryData(
              label: 'Hari, Tanggal & Waktu Lahir',
              value: birthDateTime,
            ),
            ServiceApplicationSummaryData(
              label: 'Tempat Kelahiran',
              value: birthPlace,
            ),
            const ServiceApplicationSummaryData(
              label: 'Tempat Dilahirkan',
              value: 'Rumah Sakit / Rumah Bersalin',
            ),
            const ServiceApplicationSummaryData(
              label: 'Catatan Medis',
              value: '',
              isSectionTitle: true,
            ),
            ServiceApplicationSummaryData(
              label: 'Jenis Kelahiran',
              value: birthType,
            ),
            const ServiceApplicationSummaryData(
              label: 'Penolong Kelahiran',
              value: 'Dokter, Bidan',
            ),
            ServiceApplicationSummaryData(
              label: 'Berat & Panjang Badan',
              value: '$birthWeight kg / $birthLength cm',
            ),
          ],
        ),
        const SizedBox(height: 18),
        const ServiceApplicationSubsectionTitle(
          title: 'Data Saksi',
        ),
        const SizedBox(height: 12),
        const ServiceApplicationSummaryGroup(
          title: 'Saksi Pertama',
          rows: [
            ServiceApplicationSummaryData(
              label: 'Nama',
              value: 'Idham Arhadian',
            ),
            ServiceApplicationSummaryData(
              label: 'Pekerjaan',
              value: 'Tenaga Medis',
            ),
          ],
        ),
        const SizedBox(height: 12),
        const ServiceApplicationSummaryGroup(
          title: 'Saksi Kedua',
          rows: [
            ServiceApplicationSummaryData(
              label: 'Nama',
              value: 'Nining Wijayanto',
            ),
            ServiceApplicationSummaryData(
              label: 'Pekerjaan',
              value: 'Tenaga Medis',
            ),
          ],
        ),
        const SizedBox(height: 14),
        ServiceApplicationTermsCheckbox(
          value: isTermsAccepted,
          onChanged: onTermsChanged,
        ),
        const SizedBox(height: 14),
        ServiceApplicationActions(
          primaryLabel: 'Kirim',
          onPrimaryPressed: isTermsAccepted ? onSubmit : null,
          onSecondaryPressed: onPrevious,
          onCancelPressed: onCancel,
        ),
      ],
    );
  }
}