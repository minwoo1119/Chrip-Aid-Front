import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../viewmodel/notice_viewmodel.dart';
import 'package:chrip_aid/common/styles/styles.dart';

final noticeViewModelProvider = ChangeNotifierProvider((ref) => NoticeViewModel());

class NoticeScreen extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final viewModel = ref.watch(noticeViewModelProvider);

    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      child: ConstrainedBox(
        constraints: BoxConstraints(maxWidth: 500), // 가로 너비 제한
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "기부 혜택 및 개인정보 안내",
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
                      const Divider(thickness: 2, color: CustomColor.mainColor), // 구분선
                      buildSectionTitle("세액 공제 혜택 안내"),
                      buildSectionContent(
                        "- 기부금 영수증을 통해 연말정산 시 세액 공제를 받을 수 있습니다.\n"
                            "- 구체적인 공제 방법과 절차는 국세청 연말정산 가이드를 참고해 주세요.",
                      ),
                      CheckboxListTile(
                        title: Text("세액 공제 혜택을 확인했습니다."),
                        value: viewModel.isTaxBenefitChecked,
                        onChanged: (value) {
                          viewModel.updateTaxBenefitChecked(value!);
                        },
                      ),
                      const Divider(thickness: 2, color: CustomColor.mainColor), // 구분선
                      buildSectionTitle("기부금 영수증 발급 안내"),
                      buildSectionContent(
                        "- 기부금 영수증 발급을 원하시면, 아래 개인정보 수집 및 이용에 대한 동의를 진행해 주세요.\n"
                            "- 필수 수집 항목: 이름, 주민등록번호, 주소, 연락처 등.\n"
                            "- 제공된 정보는 오직 기부금 영수증 발급을 위한 용도로만 사용됩니다.",
                      ),
                      CheckboxListTile(
                        title: Text("기부금 영수증 발급 안내를 확인했습니다."),
                        value: viewModel.isDonationChecked,
                        onChanged: (value) {
                          viewModel.updateDonationChecked(value!);
                        },
                      ),
                      const Divider(thickness: 2, color: CustomColor.mainColor), // 구분선
                      buildSectionTitle("개인정보 수집 및 이용 동의"),
                      buildSectionContent(
                        "- 수집 항목: 이름, 주민등록번호, 주소, 연락처.\n"
                            "- 이용 목적: 기부금 영수증 발급, 세액 공제 혜택 안내.\n"
                            "- 보유 기간: 기부금 영수증 발급 후 5년간 보관 후 폐기.",
                      ),
                      CheckboxListTile(
                        title: Text("개인정보 수집 및 이용 동의에 동의했습니다."),
                        value: viewModel.isPersonalInfoChecked,
                        onChanged: (value) {
                          viewModel.updatePersonalInfoChecked(value!);
                        },
                      ),
                      const Divider(thickness: 2, color: CustomColor.mainColor), // 구분선
                      buildSectionTitle("문의 안내"),
                      buildSectionContent(
                        "- 기부금 영수증 발급 관련 문의는 고객센터(02-123-4567) 또는 support@example.com으로 연락해 주세요.",
                      ),
                      CheckboxListTile(
                        title: Text("문의 안내를 확인했습니다."),
                        value: viewModel.isContactInfoChecked,
                        onChanged: (value) {
                          viewModel.updateContactInfoChecked(value!);
                        },
                      ),
                      const Divider(thickness: 2, color: CustomColor.mainColor), // 구분선
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text("위의 모든 사항을 확인하였습니다."),
                  const SizedBox(width: 10),
                  ElevatedButton(
                    onPressed: viewModel.isAllChecked ? () {
                      Navigator.pop(context); // 팝업 닫기
                      Navigator.pushNamed(context, '/confirmation'); // 확인 페이지로 이동
                    } : null,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: CustomColor.mainColor, // 메인 컬러 사용
                    ),
                    child: Text("확인"),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  // 섹션 제목을 만드는 함수
  Widget buildSectionTitle(String title) {
    return Text(
      title,
      style: TextStyle(
        fontWeight: FontWeight.bold,
        fontSize: 18,
        color: CustomColor.mainColor, // 메인 컬러 사용
      ),
    );
  }

  // 섹션 내용을 만드는 함수
  Widget buildSectionContent(String content) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Text(
        content,
        style: TextStyle(fontSize: 16),
      ),
    );
  }
}
