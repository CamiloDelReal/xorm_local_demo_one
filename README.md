# XOrm persistance with One to One relationship
One to One relationship using XOrm library

### Features
- Members
  * CRUD operations
- Departments
  * CRUD operations
- MVVM architecture

### Entity relationship diagram
<p float="left">
<img src="https://github.com/CamiloDelReal/xorm_local_demo_one/blob/develop/design/exported_diagrams/persistence.jpg" width="50%" height="50%" />
</p>

### Entities definition

    class Member : public QObject, public XTableModel<Member>
	{
		Q_OBJECT

		Q_PROPERTY(quint64 guid READ guid WRITE setGuid NOTIFY guidChanged)
		Q_PROPERTY(QString name READ name WRITE setName NOTIFY nameChanged)
		Q_PROPERTY(QString job READ job WRITE setJob NOTIFY jobChanged)

		X_TABLE_NAME("members")
		X_TABLE_FIELDS(X_FIELD(guid, X_PRIMARY_KEY),
					   X_FIELD(name),
					   X_FIELD(job))

	public:
		explicit Member(QObject *parent = nullptr);
		Member(const quint64 &guid, const QString &name, const QString &job, QObject *parent = nullptr);
		Member(const QString &name, const QString &job, QObject *parent = nullptr);
		Member(const Member &other);

		Member& operator=(const Member &other);

		quint64 guid() const;
		QString name() const;
		QString job() const;

	public slots:
		void setGuid(const quint64 &guid);
		void setName(const QString &name);
		void setJob(const QString &job);

	signals:
		void guidChanged(const quint64 &guid);
		void nameChanged(const QString &name);
		void jobChanged(const QString &job);

	private:
		quint64 m_guid;
		QString m_name;
		QString m_job;
	};