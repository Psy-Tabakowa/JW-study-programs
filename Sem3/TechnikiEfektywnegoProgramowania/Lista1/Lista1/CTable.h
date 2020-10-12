#pragma once
#include <string>


class CTable
{
private:
	std::string name;
	int* array;
	int arraySize;

	static const std::string DefaultName;
	static const int DefaultArraySize;
	static const std::string CopyNameSuffix;

public:
	CTable();
	CTable(std::string name, int arrayLength);
	CTable(const CTable& other);
	~CTable();
	
	CTable& operator=(const CTable& other); // should go in pair with copy constructor

	void setName(std::string name);
	bool setNewSize(int arrayLength);
	CTable* clone(); // !!! this method should not exist and is really dangerous for the code !!!


private:
	void printTextAndName(std::string text);
};
