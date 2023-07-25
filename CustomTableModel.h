#ifndef CUSTOMTABLEMODEL_H
#define CUSTOMTABLEMODEL_H

#include <QObject>
#include <QAbstractTableModel>

class CustomTableModel: public QAbstractTableModel
{
    Q_OBJECT
public:
    CustomTableModel();
    int rowCount() const override;
    int columnCount() const override;
    bool setData(const QModelIndex &index, const QVariant &value, int role = Qt::EditRole);

private:

};

#endif // CUSTOMTABLEMODEL_H
