local Logger = {}

function Logger:log(message)
	print(message)
	-- ������������� ����� ���������� ���� �� ������� ������ ��� �����������
end

function Logger:warn(message)
	warn(message)
	-- ������������� ����� ���������� �������������� �� ������� ������ ��� �����������
end

function Logger:error(message)
	error(message)
	-- ������������� ����� ���������� ������ �� ������� ������ ��� �����������
end

return Logger