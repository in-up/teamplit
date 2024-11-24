function CheckAddTeam() {

    var teamName = document.getElementById("teamName");
    var teamCapacity = document.getElementById("teamCapacity");
    var teamManagerId = document.getElementById("teamManagerId");
    var teamDescription = document.getElementById("teamDescription");
    var teamInviteCode = document.getElementById("teamInviteCode");

    if (!check(/^[A-Za-z0-9가-힣\s]+$/, teamName, "[팀명]\n팀 이름은 4글자 이상이어야 하며, '--'를 사용할 수 없습니다.")) {
        return false;
    }
    if (teamName.value.length < 4) {
        alert("[팀명]\n최소 4자 이상 입력하세요.");
        teamName.focus();
        return false;
    }
    if (teamName.value.includes("--")) {
        alert("[팀명]\n'--'를 사용할 수 없습니다.");
        teamName.focus();
        return false;
    }

    if (teamCapacity.value < 1 || teamCapacity.value > 30) {
        alert("[최대 인원]\n최대 정원은 1명 이상 30명 이하로 입력해야 합니다.");
        teamCapacity.focus();
        return false;
    }

    if (teamInviteCode.value.length < 4) {
        alert("[초대 코드]\n초대 코드는 4글자 이상 입력해야 합니다.");
        teamInviteCode.focus();
        return false;
    }
    if (teamInviteCode.value.includes("--")) {
        alert("[초대 코드]\n'--'를 사용할 수 없습니다.");
        teamInviteCode.focus();
        return false;
    }

    if (teamDescription.value.length < 60) {
        alert("[팀 설명]\n최소 60자 이상 입력하세요.");
        teamDescription.focus();
        return false;
    }
    if (teamDescription.value.includes("--")) {
        alert("[팀 설명]\n'--'를 사용할 수 없습니다.");
        teamDescription.focus();
        return false;
    }

    document.newTeam.submit();
}

function check(regExp, e, msg) {
    if (regExp.test(e.value)) {
        return true;
    }
    alert(msg);
    e.focus();
    return false;
}
