%if 0%{?qubes_builder}
%define _sourcedir %(pwd)/signify
%define _builddir %(pwd)/signify
%endif

Name:		signify
Version:	23
Release:	1%{?dist}
Summary:	Cryptographically sign and verify files

Group:		System Environment/Base
License:	BSD
URL:		https://github.com/aperezdc/signify

BuildRequires:	libbsd-devel
BuildRequires:	make
BuildRequires:	gcc

Requires:	libbsd

%description
The signify utility creates and verifies cryptographic signatures.

%prep

%build
make %{?_smp_mflags}

%install
%make_install PREFIX=/usr

%files
/usr/bin/signify
%doc
/usr/share/man/man1/signify.1.gz

%changelog

