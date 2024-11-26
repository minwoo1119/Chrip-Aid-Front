import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../viewmodel/notice_viewmodel.dart';
import 'package:chrip_aid/common/styles/styles.dart';

final noticeViewModelProvider = ChangeNotifierProvider((ref) => NoticeViewModel());

class NoticeScreen extends ConsumerWidget {
  final VoidCallback onConfirm;

  NoticeScreen({required this.onConfirm});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final viewModel = ref.watch(noticeViewModelProvider);

    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.grey[50],
          borderRadius: BorderRadius.circular(15),
        ),
        child: ConstrainedBox(
          constraints: BoxConstraints(maxWidth: 500), // Limit the width
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Donation Notice",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                    color: Colors.black, // Main color
                  ),
                ),
                const SizedBox(height: 16),
                Expanded(
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Tax Deduction Benefits Section
                        _buildCardSection(
                          title: "Tax Deduction Benefits",
                          content:
                          "- You can receive tax deductions through donation receipts during year-end tax adjustments.\n"
                              "- Donation receipts are issued based on Article 34 of the Income Tax Act and the Restriction of Special Taxation Act.\n"
                              "- Donations can receive tax deductions of 15% up to a maximum of 30% during year-end tax adjustments for salaried workers.\n"
                              "- For specific deduction methods and procedures, please refer to the National Tax Service’s year-end tax adjustment guide.",
                          isChecked: viewModel.isTaxBenefitChecked,
                          onChanged: (value) => viewModel.updateTaxBenefitChecked(value!),
                        ),
                        const SizedBox(height: 16),

                        // Donation Receipt Issuance Section
                        _buildCardSection(
                          title: "Donation Receipt Issuance",
                          content:
                          "- Donation receipts are necessary documents to receive tax deductions during year-end tax adjustments.\n"
                              "- After donating, please send your name, resident registration number, address, and donation details to the orphanage.\n"
                              "- Receipts will be issued within 3-5 days after the request, and will be sent to the email registered during membership sign-up.\n"
                              "- The received donation receipt can be submitted as a deduction item during year-end tax adjustments or income tax filings to receive tax deductions.",
                          isChecked: viewModel.isDonationChecked,
                          onChanged: (value) => viewModel.updateDonationChecked(value!),
                        ),
                        const SizedBox(height: 16),

                        // Personal Information Collection and Consent Section
                        _buildPersonalInfoCardSection(viewModel),

                        const SizedBox(height: 16),

                        // Contact Information Section
                        _buildCardSection(
                          title: "Contact Information",
                          content:
                          "- For inquiries related to donation receipt issuance, please contact the orphanage via the chat feature.",
                          isChecked: viewModel.isContactInfoChecked,
                          onChanged: (value) => viewModel.updateContactInfoChecked(value!),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "I have reviewed all the above items.",
                      style: TextStyle(fontSize: 16),
                    ),
                    ElevatedButton(
                      onPressed: viewModel.isAllChecked
                          ? () {
                        onConfirm();
                      }
                          : null,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: CustomColor.mainColor, // Main color
                      ),
                      child: Text(
                        "Confirm",
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildCardSection({
    required String title,
    required String content,
    required bool isChecked,
    required ValueChanged<bool?> onChanged,
  }) {
    return Card(
      color: Colors.grey[100],
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      margin: const EdgeInsets.symmetric(vertical: 8),
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16,
                color: CustomColor.mainColor,
              ),
            ),
            const SizedBox(height: 8),
            Text(content),
            const SizedBox(height: 12),
            CheckboxListTile(
              title: Text("I have reviewed $title."),
              value: isChecked,
              activeColor: CustomColor.mainColor,
              onChanged: onChanged,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPersonalInfoCardSection(NoticeViewModel viewModel) {
    return Card(
      color: Colors.grey[100],
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      margin: const EdgeInsets.symmetric(vertical: 8),
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Consent to Collect and Use Personal Information",
              style: TextStyle(
                color: CustomColor.mainColor,
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
            ),
            const SizedBox(height: 12),
            Text(
              "Collection Items:",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 4),
            Text("- Name, Resident Registration Number, Address, Contact Information, Donation Details"),
            const SizedBox(height: 12),

            Text(
              "Purpose of Use:",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 4),
            Text(
              "- Issuance of donation receipts\n"
                  "- Legal reporting and donation history management\n"
                  "- Sponsor management\n"
                  "- Customer support and inquiry handling\n"
                  "- Optional marketing and event information provision",
            ),
            const SizedBox(height: 12),

            Text(
              "Retention Period:",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 4),
            Text("- The information will be retained for 5 years after the issuance of the donation receipt, after which it will be destroyed."),
            const SizedBox(height: 12),

            Text(
              "Recipients:",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 4),
            Text("- The National Tax Service and the orphanage issuing the donation receipts."),
            const SizedBox(height: 12),

            Text(
              "Right to Refuse Consent:",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 4),
            Text("- If you refuse to provide consent, you may not be able to receive a donation receipt."),
            const SizedBox(height: 12),

            Text(
              "Security and Protection:",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 4),
            Text(
              "- Collected personal information is encrypted and stored securely, and will not be used for purposes other than those approved.",
            ),
            const SizedBox(height: 12),
            CheckboxListTile(
              title: Text("I agree to the collection and use of personal information."),
              value: viewModel.isPersonalInfoChecked,
              activeColor: CustomColor.mainColor,
              onChanged: (value) {
                viewModel.updatePersonalInfoChecked(value!);
              },
            ),
          ],
        ),
      ),
    );
  }
}

/*
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../viewmodel/notice_viewmodel.dart';
import 'package:chrip_aid/common/styles/styles.dart';

final noticeViewModelProvider = ChangeNotifierProvider((ref) => NoticeViewModel());

class NoticeScreen extends ConsumerWidget {
  final VoidCallback onConfirm;

  NoticeScreen({required this.onConfirm});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final viewModel = ref.watch(noticeViewModelProvider);

    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.grey[50],
          borderRadius: BorderRadius.circular(15),
        ),
        child: ConstrainedBox(
          constraints: BoxConstraints(maxWidth: 500),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "기부금 관련 안내",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                    color: Colors.black,
                  ),
                ),
                const SizedBox(height: 16),
                Expanded(
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // 세액 공제 혜택 안내 섹션
                        _buildCardSection(
                          title: "세액 공제 혜택 안내",
                          content:
                          "- 기부금 영수증을 통해 연말정산 시 세액 공제를 받을 수 있습니다.\n"
                              "- 기부금 영수증은 소득세법 제34조 및 조세특례제한법에 근거하여 발급됩니다.\n"
                              "- 기부금은 근로소득자의 연말정산 시 15%에서 최대 30%까지 세액 공제를 받을 수 있습니다.\n"
                              "- 구체적인 공제 방법과 절차는 국세청 연말정산 가이드를 참고해 주세요.",
                          isChecked: viewModel.isTaxBenefitChecked,
                          onChanged: (value) => viewModel.updateTaxBenefitChecked(value!),
                        ),
                        const SizedBox(height: 16),

                        // 기부금 영수증 발급 안내 섹션
                        _buildCardSection(
                          title: "기부금 영수증 발급 안내",
                          content:
                          "- 기부금 영수증은 연말정산 시 세액 공제를 받기 위한 필수 서류입니다.\n"
                              "- 기부 후 성명, 주민등록번호, 주소, 기부 내역을 보육원에 전달해 주세요.\n"
                              "- 발급 요청 후 3~5일 내에 영수증이 발급되며, 가입 시 등록한 이메일로 전송됩니다.\n"
                              "- 발급된 기부금 영수증은 연말정산 또는 종합소득세 신고 시 소득공제 항목으로 제출할 수 있습니다.",
                          isChecked: viewModel.isDonationChecked,
                          onChanged: (value) => viewModel.updateDonationChecked(value!),
                        ),
                        const SizedBox(height: 16),

                        // 개인정보 수집 및 이용 동의 섹션
                        _buildPersonalInfoCardSection(viewModel),

                        const SizedBox(height: 16),

                        // 문의 안내 섹션
                        _buildCardSection(
                          title: "문의 안내",
                          content:
                          "- 기부금 영수증 발급 관련 문의는 채팅 기능을 통해 보육원 측에 연락해 주세요.",
                          isChecked: viewModel.isContactInfoChecked,
                          onChanged: (value) => viewModel.updateContactInfoChecked(value!),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "위의 모든 항목을 확인했습니다.",
                      style: TextStyle(fontSize: 16),
                    ),
                    ElevatedButton(
                      onPressed: viewModel.isAllChecked
                          ? () {
                        onConfirm();
                      }
                          : null,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: CustomColor.mainColor,
                      ),
                      child: Text(
                        "확인",
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildCardSection({
    required String title,
    required String content,
    required bool isChecked,
    required ValueChanged<bool?> onChanged,
  }) {
    return Card(
      color: Colors.grey[100],
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      margin: const EdgeInsets.symmetric(vertical: 8),
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16,
                color: CustomColor.mainColor,
              ),
            ),
            const SizedBox(height: 8),
            Text(content),
            const SizedBox(height: 12),
            CheckboxListTile(
              title: Text("$title을 확인했습니다."),
              value: isChecked,
              activeColor: CustomColor.mainColor,
              onChanged: onChanged,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPersonalInfoCardSection(NoticeViewModel viewModel) {
    return Card(
      color: Colors.grey[100],
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      margin: const EdgeInsets.symmetric(vertical: 8),
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "개인정보 수집 및 이용 동의",
              style: TextStyle(
                color: CustomColor.mainColor,
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
            ),
            const SizedBox(height: 12),
            Text(
              "수집 항목:",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 4),
            Text("- 성명, 주민등록번호, 주소, 연락처, 기부 내역"),
            const SizedBox(height: 12),

            Text(
              "이용 목적:",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 4),
            Text(
              "- 기부금 영수증 발급\n"
                  "- 법적 신고 및 기부 내역 관리\n"
                  "- 후원자 관리\n"
                  "- 고객 지원 및 문의 처리\n"
                  "- 선택적 마케팅 및 이벤트 정보 제공",
            ),
            const SizedBox(height: 12),

            Text(
              "보유 기간:",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 4),
            Text("- 기부금 영수증 발급 후 5년간 보관 후 파기."),
            const SizedBox(height: 12),

            Text(
              "제공 대상:",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 4),
            Text("- 국세청 및 기부금 영수증 발급을 위한 보육원."),
            const SizedBox(height: 12),

            Text(
              "동의 거부 권리:",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 4),
            Text("- 동의하지 않을 경우 기부금 영수증 발급이 불가할 수 있습니다."),
            const SizedBox(height: 12),

            Text(
              "보안 및 보호:",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 4),
            Text(
              "- 수집된 개인정보는 암호화되어 안전하게 저장되며, 승인된 목적 외에는 사용되지 않습니다.",
            ),
            const SizedBox(height: 12),
            CheckboxListTile(
              title: Text("개인정보 수집 및 이용에 동의합니다."),
              value: viewModel.isPersonalInfoChecked,
              activeColor: CustomColor.mainColor,
              onChanged: (value) {
                viewModel.updatePersonalInfoChecked(value!);
              },
            ),
          ],
        ),
      ),
    );
  }
}

 */